Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932666AbWKELku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbWKELku (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 06:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbWKELku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 06:40:50 -0500
Received: from viefep13-int.chello.at ([213.46.255.16]:19789 "EHLO
	viefep17-int.chello.at") by vger.kernel.org with ESMTP
	id S932666AbWKELkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 06:40:49 -0500
Message-ID: <454DCDBC.7060201@freemail.hu>
Date: Sun, 05 Nov 2006 12:40:44 +0100
From: =?ISO-8859-2?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu; rv:1.7.12) Gecko/20050920
X-Accept-Language: hu, en, de
MIME-Version: 1.0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] input: map BTN_FORWARD to button 2 in mousedev
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Márton Németh <nm127@freemail.hu>

In mousedev the BTN_LEFT and BTN_FORWARD were mapped to mouse button 0, causing
that the user space program cannot distinguish between them through /dev/input/mice.
The BTN_FORWARD is currently used in the synaptics.c, logips2pp.c and in alps.c. All
mice have BTN_LEFT, but not all have BTN_MIDDLE (e.g. Clevo D410J laptop). Mapping
BTN_FORWARD to mouse button 2 makes the BTN_FORWARD button useful on the mentioned
laptop.

Signed-off-by: Márton Németh <nm127@freemail.hu>
---

The Clevo D410J laptop has "AlpsPS/2 ALPS GlidePoint" touchpad having the following
physical layout:

     +-------------------+ +-------------+ +-------------------+
     |                   | | BTN_FORWARD | |                   |
     |     BTN_LEFT      | +-------------+ |     BTN_RIGHT     |
     |                   | +-------------+ |                   |
     |                   | |  BTN_BACK   | |                   |
     +-------------------+ +-------------+ +-------------------+

This model does not have any BTN_MIDDLE, but the BTN_FORWARD could be used instead.
The following table summarizes the map changes:

     Button name  | Mapping in 2.6.19-rc3 | The changed mapping
     -------------+-----------------------+---------------------
     BTN_LEFT     |          0            |          0
     BTN_RIGHT    |          1            |          1
     BTN_FORWARD  |          0            |          2
     BTN_BACK     |          3            |          3


--- linux-2.6.19-rc4/drivers/input/mousedev.c.orig	2006-10-31 04:37:36.000000000 +0100
+++ linux-2.6.19-rc4/drivers/input/mousedev.c	2006-11-05 02:34:56.000000000 +0100
@@ -196,12 +196,12 @@ static void mousedev_key_event(struct mo
  	switch (code) {
  		case BTN_TOUCH:
  		case BTN_0:
-		case BTN_FORWARD:
  		case BTN_LEFT:		index = 0; break;
  		case BTN_STYLUS:
  		case BTN_1:
  		case BTN_RIGHT:		index = 1; break;
  		case BTN_2:
+		case BTN_FORWARD:
  		case BTN_STYLUS2:
  		case BTN_MIDDLE:	index = 2; break;
  		case BTN_3:

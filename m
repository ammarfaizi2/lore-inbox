Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVAaVt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVAaVt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 16:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVAaVt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 16:49:59 -0500
Received: from sd291.sivit.org ([194.146.225.122]:60886 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261390AbVAaVtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 16:49:11 -0500
Date: Mon, 31 Jan 2005 22:49:05 +0100
From: Stelian Pop <stelian@popies.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/char/sonypi.c: make 3 structs static
Message-ID: <20050131214905.GF28886@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20050131173508.GS18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050131173508.GS18316@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 06:35:08PM +0100, Adrian Bunk wrote:

> This patch makes three needlessly global structs static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/char/sonypi.c |   76 +++++++++++++++++++++++++++++++++++++++++-
>  drivers/char/sonypi.h |   74 ----------------------------------------
>  2 files changed, 75 insertions(+), 75 deletions(-)

sonypi.h is a "local" header file used only by sonypi.c.

I would like to keep those tables in sonypi.h rather than putting 
all into sonypi.c (or we could as well remove sonypi.h and put all the
contents into the .c).

What about:

 sonypi.c |    2 +-
 sonypi.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: drivers/char/sonypi.h
===================================================================
--- a/drivers/char/sonypi.h	(revision 26543)
+++ b/drivers/char/sonypi.h	(working copy)
@@ -304,7 +304,7 @@ static struct sonypi_event sonypi_batter
 	{ 0, 0 }
 };
 
-struct sonypi_eventtypes {
+static struct sonypi_eventtypes {
 	int			model;
 	u8			data;
 	unsigned long		mask;
@@ -347,7 +347,7 @@ struct sonypi_eventtypes {
 #define SONYPI_KEY_INPUTNAME	"Sony Vaio Keys"
 
 /* Correspondance table between sonypi events and input layer events */
-struct {
+static struct {
 	int sonypiev;
 	int inputev;
 } sonypi_inputkeys[] = {
Index: drivers/char/sonypi.c
===================================================================
--- a/drivers/char/sonypi.c	(revision 26543)
+++ b/drivers/char/sonypi.c	(working copy)
@@ -645,7 +645,7 @@ static struct file_operations sonypi_mis
 	.ioctl		= sonypi_misc_ioctl,
 };
 
-struct miscdevice sonypi_misc_device = {
+static struct miscdevice sonypi_misc_device = {
 	.minor		= -1,
 	.name		= "sonypi",
 	.fops		= &sonypi_misc_fops,
> 

-- 
Stelian Pop <stelian@popies.net>

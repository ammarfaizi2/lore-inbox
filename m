Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTJ0HsP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 02:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbTJ0HsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 02:48:14 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:43233 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S261294AbTJ0HsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 02:48:14 -0500
Message-ID: <3F9CCF0A.1010702@pacbell.net>
Date: Sun, 26 Oct 2003 23:53:46 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Vadim <lkml@vadim.ws>
CC: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Subject: Re: APM suspend on 2.6.0-test9 causes Toshiba 470CDT laptop to hang
 after resume
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ... it hung on sync. The kernel seems to continue working, for 
> example I can scroll up, but anything I try to run hangs. USB 
> seems to break as well ...

Sounds exactly like the symptoms that lead me to this patch
(against test7):

   http://marc.theaimsgroup.com/?l=linux-kernel&m=106606272103414&w=2

The issue could show with any resume where the USB controller
lost power, so the devices (including root hub) which were
there before the suspend need to be removed during resume.
That would include swsusp, as well as D3cold.

Patrick has a similar patch, which he's not yet submitted.

- Dave


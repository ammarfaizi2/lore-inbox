Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266222AbUAQXin (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 18:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266223AbUAQXin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 18:38:43 -0500
Received: from hera.cwi.nl ([192.16.191.8]:15768 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S266222AbUAQXim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 18:38:42 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 18 Jan 2004 00:38:37 +0100 (MET)
Message-Id: <UTC200401172338.i0HNcbY14541.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: Making MO drive work with ide-cd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Long ago we had a thread here with approximately the above subject.
I see fragments of discussion like

- if (drive->media == ide_cdrom)
+ if (drive->media == ide_cdrom || drive->media == ide_optical)
                         (void) request_module("ide-cd");

> Definitely, this looks like a fine start. As far as I'm concerned, it
> would be fine to commit to 2.5. 

and still today, by default ide_optical is sent to ide-cd.

I wonder whether that is meaningful.

By some coincidence I got hold of an MO drive today. Under 2.4.21
and 2.6.1 using ide-scsi all seems to work at first sight.
With ide-cd I get errors only.
Not surprising: ide-cd expects a CD so sends READ_TOC and
gets "illegal request / invalid command" back.
The appropriate command is READ CAPACITY.

Are there cases where ide-cd is useful?
Should we retarget ide_optical to ide-scsi?

Andries

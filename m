Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVCUPuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVCUPuF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 10:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVCUPti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 10:49:38 -0500
Received: from alog0492.analogic.com ([208.224.223.29]:14783 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261840AbVCUPs7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 10:48:59 -0500
Date: Mon, 21 Mar 2005 10:46:25 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Invalidating dentries
In-Reply-To: <Pine.LNX.4.61.0503211626180.20464@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0503211035300.12105@chaos.analogic.com>
References: <Pine.LNX.4.61.0503211626180.20464@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005, Jan Engelhardt wrote:

> Hello list,
>
>
> how can I invalidate all buffered/cached dentries so that ls -l /somefolder
> will definitely go read the harddisk?
>

fsync() on the file(s) in the directory then fsync() on the directory
itself. For this, one can open the directory as though it was
just a file, you don't need opendir().

FYI, this is what `man fsync` promises. It may be broken. Last
time I checked, one needed to umount() the file-system to make
sure the directories were updated. The problem may be that
somebody can have either the directory or a file within it
open. Until they get out, the directory entry may not actually
be finalized. Oh,... Unix/Linux doesn't have "folders". That's
some M$ thing. Real operating systems have directories. Your
GUI may have folders, just like it may have little houses,
trash-cans, red hats, and other odd widgets. However, the
operating system doesn't.

>
> Jan Engelhardt
> --


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

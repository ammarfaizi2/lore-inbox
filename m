Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269425AbUIYWPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269425AbUIYWPg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 18:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269429AbUIYWPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 18:15:35 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:63164 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269425AbUIYWPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 18:15:34 -0400
Message-ID: <58cb370e04092515157e9b72ef@mail.gmail.com>
Date: Sun, 26 Sep 2004 00:15:33 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: micah milano <micaho@gmail.com>
Subject: Re: SiI3112 Serial ATA Maxtor 6Y120M0 incorrect geometry detected
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <70fda3204092514037c6dc039@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <70fda320409251214129bba57@mail.gmail.com>
	 <70fda3204092514037c6dc039@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This was discussed to death on lkml.

To make long story short:
- BIOS CHS is _useless_ for IDE driver
- IDE driver returns different geometry for 2.[2,4,6].x kernels
- Andries removed ide-geometry.c in 2.5 but didn't HDIO_GETGEO ioctl
- BIOS CHS is available through EDD driver now
- this is a parted problem

I'm tired of this issue and this is what I'm going to do:
- remove CHS info from IDE printks and /proc/ide/
- add BLKGETSTART ioctl for getting partition's start sector
  (this is the only legitimate use of HDIO_GETGEO currently)
- at least obsolete HDIO_GETGEO in IDE or even remove it (failing is
  better than returning unexpected results)
- silence complainers :)

Bartlomiej

On Sat, 25 Sep 2004 16:03:15 -0500, micah milano <micaho@gmail.com> wrote:
> Some interesting additional information... if I boot with 2.4.25, the
> CHS in the dmesg changes to something else, in 2.6.7 it was
> CHS=65535/16/63, in 2.4.25 it becomes CHS=238216/16/63.

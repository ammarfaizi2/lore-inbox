Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310788AbSCLMiW>; Tue, 12 Mar 2002 07:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310940AbSCLMiM>; Tue, 12 Mar 2002 07:38:12 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:13587 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S310788AbSCLMiE>; Tue, 12 Mar 2002 07:38:04 -0500
Date: Tue, 12 Mar 2002 12:58:53 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: linux-kernel@vger.kernel.org
cc: ak@muc.de
Subject: __get_user usage in mm/slab.c
Message-ID: <Pine.LNX.4.21.0203121237070.19747-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The way __get_user is currently used in mm/slab.c is not portable. It
breaks on arch which have seperate user/kernel memory space. It still
works during boot or from kernel threads, but /proc/slabinfo shows only 
broken entries or if a module creates a slab cache, I got lots of
warnings.
We have to at least insert a "set_fs(get_fs())", but IMO a separate
interface would be better. Any opinions?

bye, Roman


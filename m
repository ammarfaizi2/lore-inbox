Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262396AbRENTQK>; Mon, 14 May 2001 15:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbRENTQA>; Mon, 14 May 2001 15:16:00 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:57616 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S262392AbRENTPu>;
	Mon, 14 May 2001 15:15:50 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
Date: Mon, 14 May 2001 21:14:26 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: uid_t and gid_t vs.  __kernel_uid_t and __kernel_gid_t
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <2E927786773@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 May 01 at 15:00, Khachaturov, Vassilii wrote:

> I had to communicate uid/gid from an application down 
> to a driver, and discovered that uid and gid in user
> space are different from those in kernel space.

ncpfs uses 'unsigned long' in its ncp_mount_data_v4, as MIPS uses
'long' type for uid/gid. Unfortunately it still needs conversions
on some archs, so maybe using u_int64_t is just best solution
(AFAIK as MIPS unsigned long is 64bit, you have to use u_int64_t
if you want same type accross architectures).

Kernel part then just checks wheter uid == (__kernel_uid_t)uid and 
gives up if they differ.
                                    Best regards,
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz

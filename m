Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266050AbUAFAmh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266049AbUAFAm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:42:27 -0500
Received: from p508297A4.dip.t-dialin.net ([80.130.151.164]:18950 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S266050AbUAFAlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:41:19 -0500
Date: Tue, 6 Jan 2004 00:44:35 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Relocation overflow with modules on Alpha
Message-ID: <20040106004435.A3228@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
	linux-kernel@vger.kernel.org
References: <yw1xy8sn2nry.fsf@ford.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <yw1xy8sn2nry.fsf@ford.guide>; from mru@kth.se on Mon, Jan 05, 2004 at 02:21:37AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 02:21:37AM +0100, Måns Rullgård wrote:
> 
> I compiled Linux 2.6.0 for Alpha, and it mostly works, except the
> somewhat large modules.  They fail to load with the message
> "Relocation overflow vs section 17", or some other section number.
> I've seen this with scsi-mod, nfsd, snd-page-alloc and possibly some
> more.  Compiling them statically works.  What's going on?

I saw a similar thing, but I'm compiling everything statically:

: relocation truncated to fit: BRADDR .init.text
init/built-in.o(.text+0xf10): In function `inflate_codes':


Disabling a not so important subsystem (sound) helped for the time being.

It seems my kernel crossed the 4 MB barrier in consumed RAM and possibly
some relocation type(s) can't cope with that. Time to use -fpic or 
some such?

Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292639AbSBZSOl>; Tue, 26 Feb 2002 13:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292633AbSBZSOX>; Tue, 26 Feb 2002 13:14:23 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:38408 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S292612AbSBZSOL>; Tue, 26 Feb 2002 13:14:11 -0500
Date: Tue, 26 Feb 2002 19:14:09 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020226191409.A23093@devcon.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020226171634.GL4393@matchmail.com> <Pine.LNX.4.44L.0202261419240.1413-100000@duckman.distro.conectiva> <20020226173822.GN4393@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020226173822.GN4393@matchmail.com>; from mfedyk@matchmail.com on Tue, Feb 26, 2002 at 09:38:22AM -0800
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 09:38:22AM -0800, Mike Fedyk wrote:
> 
> Basically, it would only move the files to the undelete area if the link
> count == 1.  If you just decremented the link, then unlink() in glibc would
> work as it does now.

Always racy if done in userspace, unless you introduce a centralised
"unlink daemon" (hope no glibc developer reads that, they might be
tempted to implement such an abomination...):

     proc1       proc2
   --------------------
    stat()
                stat()
    unlink()
                unlink()

*kaboom*, blackhole opens, file is gone.

/If/ you start doing such a mess (personally I don't want undeletion
anyways), please do it at least in a correct way.

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net

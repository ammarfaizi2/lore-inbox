Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSDWMCz>; Tue, 23 Apr 2002 08:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315181AbSDWMCy>; Tue, 23 Apr 2002 08:02:54 -0400
Received: from boden.synopsys.com ([204.176.20.19]:3509 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S315178AbSDWMCw>; Tue, 23 Apr 2002 08:02:52 -0400
Date: Tue, 23 Apr 2002 14:02:39 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Chris Wright <chris@wirex.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SECURITY] FDs 0, 1, 2 for SUID/SGID programs
Message-ID: <20020423140239.C1142@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Chris Wright <chris@wirex.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <87662jiz3b.fsf@CERT.Uni-Stuttgart.DE> <20020422121819.A13864@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2002 at 12:18:19PM -0700, Chris Wright wrote:
> * Florian Weimer (Weimer@CERT.Uni-Stuttgart.DE) wrote:
> > http://www.pine.nl/advisories/pine-cert-20020401.html probably affects
> > Linux, too (if a SUID/SGID program is invoked with FD 2 closed, error
> > messages might be written to a file opened by the program ).
> 
> AFAIK, the standards clearly specify behaviour wrt. open file descriptors
> and clone-on-exec file descriptors across execve().  However, there

that is close-on-exec. Different semantics.

       F_GETFD  Read  the  close-on-exec flag.  If the FD_CLOEXEC
                bit is 0, the file will remain open across  exec,
                otherwise it will be closed.


> is nothing specified when it comes to closed file descpriptors across
> execve(), notably FD's 0, 1 and 2 are certainly not required to be open
> across an execve() of a SUID/SGID applictaion.  One could argue that
> SUID/SGID apps that trust the file descriptors they inherit across exec()
> are buggy.
> 
> Having said that, there are a number of implementations of this type
> of protection for the linux kernel stemming from the Openwall project.
> If you are interested, see:
> 
> 	http://www.openwall.com	(CONFIG_SECURE_FD_0_1_2)
> 	http://lsm.immunix.org	(CONFIG_OWLSM_FD)
> 	http://grsecurity.net	(CONFIG_GRKERNSEC_FD)

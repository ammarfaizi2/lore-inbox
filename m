Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273588AbRJDI7v>; Thu, 4 Oct 2001 04:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273789AbRJDI7l>; Thu, 4 Oct 2001 04:59:41 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:11153 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S273588AbRJDI7e>; Thu, 4 Oct 2001 04:59:34 -0400
From: Christoph Rohland <cr@sap.com>
To: Paul Menage <pmenage@ensim.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Pollable /proc/<pid>/ - avoid SIGCHLD/poll() races
In-Reply-To: <E15p3JS-0000ko-00@pmenage-dt.ensim.com>
Organisation: SAP LinuxLab
Date: 04 Oct 2001 10:59:07 +0200
In-Reply-To: <E15p3JS-0000ko-00@pmenage-dt.ensim.com>
Message-ID: <m34rpfpyqs.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, 04 Oct 2001, Paul Menage wrote:
> 
> I've recently run across a problem where a server (in this case,
> sshd) can deadlock itself if a SIGCHLD arrives just before it calls
> select(), but after it has checked whether its child_terminated. So
> when the select() is called, the SIGCHLD signal handler has already
> run and set the child_terminated flag, and there's nothing to wake
> the select().
> 
> The only real user-space solution to this is to have the SIGCHLD
> handler somehow cause the select() to return immediately

... or implement pselect:
http://mesh.eecs.umich.edu/cgi-bin/man2html/usr/share/man/man2/select.2.gz

or use sigsetjmp/siglongjmp

Both would be portable and not special to child handling.

Greetings
		Christoph



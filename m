Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315354AbSDWVzf>; Tue, 23 Apr 2002 17:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315358AbSDWVze>; Tue, 23 Apr 2002 17:55:34 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:30730 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S315354AbSDWVza>; Tue, 23 Apr 2002 17:55:30 -0400
Date: Tue, 23 Apr 2002 17:53:48 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Christopher Yeoh <cyeoh@samba.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        anton@samba.org, paulus@samba.org, davidm@hpl.hp.com
Subject: Re: [PATCH] SIGURG incorrectly delivered to process
In-Reply-To: <15550.24352.446276.774799@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.21.0204231753290.3945-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Apr 2002, Christopher Yeoh wrote:

> 
> If a process is sent a SIGURG signal and it is blocking SIGURG
> signals, when the process subsequently unblocks SIGURG signals it will
> be terminated even if it is set to the default action (SIG_DFL) which
> is specified by SUSv3 to ignore that signal.
> 
> The following patch fixes the problem:
> 
> --- linux-2.4.18/arch/i386/kernel/signal.c~	Thu Mar 21 16:04:30 2002
> +++ linux-2.4.18/arch/i386/kernel/signal.c	Thu Apr 18 12:19:37 2002
> @@ -658,7 +658,7 @@
>  				continue;
>  
>  			switch (signr) {
> -			case SIGCONT: case SIGCHLD: case SIGWINCH:
> +			case SIGCONT: case SIGCHLD: case SIGWINCH: case SIGURG:
>  				continue;
>  
>  			case SIGTSTP: case SIGTTIN: case SIGTTOU:
> 
> A quick browse of the other architectures indicates that most (if not
> all) of them also need the same fix applied to their arch specific
> signal.c files.

Christopher, 

Could you please fixup (and test ;)) and other archs too ?


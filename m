Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129283AbRCENhh>; Mon, 5 Mar 2001 08:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbRCENh1>; Mon, 5 Mar 2001 08:37:27 -0500
Received: from ns.suse.de ([213.95.15.193]:48907 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129283AbRCENhT>;
	Mon, 5 Mar 2001 08:37:19 -0500
To: Jan Nieuwenhuizen <janneke@gnu.org>
Cc: Pavel Machek <pavel@suse.cz>, Erik Hensema <erik@hensema.xs4all.nl>,
        linux-kernel@vger.kernel.org, bug-bash@gnu.org
Subject: Re: binfmt_script and ^M
In-Reply-To: <20010227140333.C20415@cistron.nl>
	<E14XkQG-0003R7-00@the-village.bc.nu>
	<20010228211043.A4579@hensema.xs4all.nl> <20010301120446.A34@(none)>
	<m3k8648i94.fsf@appel.lilypond.org>
X-Yow: ...Um...Um...
From: Andreas Schwab <schwab@suse.de>
Date: 05 Mar 2001 14:37:09 +0100
In-Reply-To: <m3k8648i94.fsf@appel.lilypond.org>
Message-ID: <je4rx8pcai.fsf@hawking.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.99
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Nieuwenhuizen <janneke@gnu.org> writes:

|> Pavel Machek <pavel@suse.cz> writes:
|> 
|> > > $ head -1 testscript
|> > > #!/bin/sh
|> > > $ ./testscript
|> > > bash: ./testscript: No such file or directory
                           ^^^^^^^^^^^^^^^^^^^^^^^^^
|> > 
|> > What kernel wants to say is "/usr/bin/perl\r: no such file". Saying ENOEXEC
|> > would be even more confusing.
|> 
|> So, why don't we make bash say that, then?  As I guess that we've all
|> been bitten by this before.
|> 
|> What are the chances for something like this to be included?

Very low, because it would not change anything.

|> @@ -3155,7 +3191,12 @@
|>  
|>        if (command == 0)
|>  	{
|> -	  internal_error ("%s: command not found", pathname);
                               ^^^^^^^^^^^^^^^^^
|> +	  char buf[80];
|> +	  char *interpreter = extract_hash_bang_interpreter (pathname, buf);
|> +	      
|> +	  internal_error ("%s: command not found: `%s'", pathname,
|> +			  interpreter);
|> +	  
|>  	  exit (EX_NOTFOUND);	/* Posix.2 says the exit status is 127 */
|>  	}

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5

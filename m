Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265449AbRGGWjV>; Sat, 7 Jul 2001 18:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265452AbRGGWjL>; Sat, 7 Jul 2001 18:39:11 -0400
Received: from [213.96.124.18] ([213.96.124.18]:24304 "HELO dardhal")
	by vger.kernel.org with SMTP id <S265449AbRGGWix>;
	Sat, 7 Jul 2001 18:38:53 -0400
Date: Sun, 8 Jul 2001 00:40:51 +0000
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jldomingo@crosswinds.net>
To: linux-kernel@vger.kernel.org
Subject: Re: OOM: A Success Report
Message-ID: <20010708004051.A4765@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <994543220.1749.0.camel@phantasy>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 07 July 2001, at 18:00:08 -0400,
Robert Love wrote:

> i thought it would be nice to finally hear something good about the OOM
> killer.
> [...]
> kernel showed:
> Out of Memory: Killed process 1296 (evolution-mail).
> [...]
> Out of Memory: Killed process 1307 (evolution-mail).
> 
<BEWARE: NEWBIE REASONING AHEAD>
I've had both succesful and not-so-sucesful times with 2.4.x's OOM killer.
Having looked at oom_kill.c code, from my newbie point of view, it _seems_
that theoretically we try to kill a process too late (that is, in
out_of_memory()	we report OOM when swap is full AND memory has
freepages.min or less 4KB pages left).

I've seem some applications cause some memory to be reserved when told to
exit normally (i.e. Mozilla). If we are OOM we just have freepages.min
pages free, that AFAIK is the first number under /proc/sys/vm/freepages,
or 512 KB worth of memory. Maybe this is not enough in some situations,
and that colud cause the machine to slow badly trying to kill something
that needs free memory, when in fact we have not free memory at all.
</BEWARE>

Another interesting thing I noted is the fact (as shown by Robert Love's
message) that oom_kill() seems to kill processes without taking into
account whether the selected process is a full application or just one
of more "threads" in some application. This happened to me when OpenOffice
went crazy and OOM hit, but instead of killing the parent process, it just
killed one of the children and, though OOM recoverd memory, OpenOffice 
ended useless. Maybe OOM should have killed the parent in the first place.

Final question: a 2.4.4 kernel with no swap activated, and OOM hit (thanks
to a purposedly executed ls ../*/../*/..) takes much more time to recover
than the same setup but with swap activated (exact numbers missing,
sorry). Moreover, when swap is of, the hard disk goes crazy as if it where
using swap, when in fact it isn't). Is this expected behaviour ?

If someone wants some test with real numbers, please let me know and
though I'm on vacation, I'll go where I work to make some test :)

Regards.

-- 
José Luis Domingo López
Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265133AbRFUTUA>; Thu, 21 Jun 2001 15:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265137AbRFUTTu>; Thu, 21 Jun 2001 15:19:50 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:60295 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S265133AbRFUTTf>; Thu, 21 Jun 2001 15:19:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        landley@webofficenow.com
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Date: Thu, 21 Jun 2001 10:18:33 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <200106211402.JAA78332@tomcat.admin.navo.hpc.mil>
In-Reply-To: <200106211402.JAA78332@tomcat.admin.navo.hpc.mil>
MIME-Version: 1.0
Message-Id: <01062110183305.00845@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 June 2001 10:02, Jesse Pollard wrote:
> Rob Landley <landley@webofficenow.com>:
> > On Wednesday 20 June 2001 17:20, Albert D. Cahalan wrote:
> > > Rob Landley writes:
> > > > My only real gripe with Linux's threads right now [...] is
> > > > that ps and top and such aren't thread aware and don't group them
> > > > right.
> > > >
> > > > I'm told they added some kind of "threadgroup" field to processes
> > > > that allows top and ps and such to get the display right.  I haven't
> > > > noticed any upgrades, and haven't had time to go hunting myself.
> > >
> > > There was a "threadgroup" added just before the 2.4 release.
> > > Linus said he'd remove it if he didn't get comments on how
> > > useful it was, examples of usage, etc. So I figured I'd look at
> > > the code that weekend, but the patch was removed before then!
> >
> > Can we give him feedback now, asking him to put it back?
> >
> > > Submit patches to me, under the LGPL please. The FSF isn't likely
> > > to care. What, did you think this was the GNU system or something?
> >
> > I've stopped even TRYING to patch bash.  try a for loop calling "echo
> > $$&", eery single process bash forks off has the PARENT'S value for $$,
> > which is REALLY annoying if you spend an afternoon writing code not
> > knowing that and then wonder why the various process's temp file sare
> > stomping each other...
>
> Actually - you have an error there. $$ gets evaluated during the parse, not
> during execution of the subprocess.

Well, that would explain it then.  (So $$ isn't actually an environment 
variable, it just looks like one?  I had my threads calling a seperate 
function...)

> To get what you are describing it is
> necessary to "sh -c 'echo $$'" to force the delay of evaluation.

Except that this spawns a new child and gives me the PID of the child, which 
lives for maybe a tenth of a second...

Maybe I could do something with eval...?

Either way, I switched the project in question to python.

> That depends on what you are trying to do.

A couple people emailed me and pointed out I had to set IFS=$'\n', (often 
after first saying "there's no way to do that" and then correcting themselves 
towards the end of the message...)

My first attempt to do it was to pipe the data into a sub-function do read a 
line at a time and store the results in an array.  (Seemed pretty 
straightforward.)

Except there's no way to get that array back out of the function, and that IS 
documented at the end of the bash man page.

As I said: Python.

> Are you trying to echo the
> entire "ls -l"? or are you trying to convert an "ls -l" into a single
> column based on a field extracted from "ls -l".

I was trying to convert the lines into an array I could then iterate through.

> If the fields don't matter, but you want each line processed in the
> loop do:
>
> ls -l | while read i
> do
>    echo line:$i
> done

Hmmm...  If that avoids the need to export the array from one shell instance 
to another, maybe it'd work.  (I'm not really doing echo, I was doing 
var[$i]="line", with some other misc stuff.)

But I got it to work via IFS, and that's good enough for right now.

> If you want such elaborate handling of strings, I suggest using perl.

I came to the same conclusion, but would like for more than one person to be 
able to work on the same piece of code, so it's python.  (Or PHP if Carl's 
the one who gets around to porting it first. :)  But in the meantime, the 
shell script is now working.  Thanks everybody...)

Back to talking about the kernel.:)

Rob

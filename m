Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269190AbTCBLaX>; Sun, 2 Mar 2003 06:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269191AbTCBLaX>; Sun, 2 Mar 2003 06:30:23 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:16281 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S269190AbTCBLaT>; Sun, 2 Mar 2003 06:30:19 -0500
Message-ID: <20030302114035.22346.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Date: Sun, 02 Mar 2003 12:40:35 +0100
Subject: Re: anticipatory scheduling questions
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: Andrew Morton <akpm@digeo.com> 
Date: Sat, 1 Mar 2003 02:40:24 -0800 
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> 
Subject: Re: anticipatory scheduling questions 
 
> "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> wrote: 
> > 
> > ----- Original Message -----  
> > > Does basic 2.5.63 do the same thing?  Do you have a feel 
> > > for when it started happening?  
> >   
> > This has happened since the moment I switched from 
> > 2.4 to 2.5.63-mm1.  
>  
> You have not actually said whether 2.5.63 base exhibits 
> the same problem.  From the vmstat traces it appears 
> that the answer is "yes"? 
 
Both 2.5.63 and 2.5.63-mm1 exhibit this behavior, but 
can't be reproduced with 2.4.20-2.54. 
 
> > I have retested this with 2.4.20-2.54, 2.5.63 and 2.5.63-mm1...  
> > and have attached the files to this message 
>  
> Thanks.  Note how 2.4 is consuming a few percent CPU, whereas 2.5 is 
> consuming 100%.  Approximately half of it system time. 
 
It seems is not "user" or "system" time what's being consumed, it's 
"iowait" Look below :-) 
 
> It does appear that some change in 2.5 has caused evolution to go berserk 
> during this operation. 
 
I wouldn't say it's exactly Evolution what's going berserk. Doing a 
"top -s1" while trying to reply to a big e-mail message, I've noticed 
that "top" reports "iowait" starting at ~50%, then going up very fast 
and then staying up at 90-95% all the time. This happens on 2.5.63 
and 2.5.63-mm1, however, on 2.4.20-2.54 kernel, "iowait" stays all 
the time exactly at "0%" and idle time remains steady at 90-95%. 
 
These measures were taken using "top" with a delay of 1 second, 
starting at the moment in which I try replying to a large e-mail 
message. 
 
> The next step please is: 
>  
> a) run top during the operation, work out which process is chewing all 
>    that CPU.  Presumably it will be evolution or aspell 
 
Well, the "top" command reveals that Evolution is taking very 
little CPU usage (between 1 and 6%). Nearly all the time is 
accounted under "iowait". 
 
The other Evolution processes top at a peak sum of 5% of 
CPU usage, more or less. 
 
> b) Do it again and this time run 
> 	strace -p $(pidof evolution)	# or aspell 
 
I think this is going to be difficult... as I said Evolution is a very 
complex program and it spawns a lot of processes. When I 
click the Reply, Evolution spawns two processes: 
"gnome-gtkhtml-editor" and "gnome-spell-component". 
 
I have little experience with process tracing and don't know 
how to attach to those processes from the very beginning. 
Attaching to the main Evolution process doesn't help: the "strace" 
command dumps a lot of info when Evolution starts up, but 
starts being useless at the moment I click the Reply and Evolution 
spawns these two new processes to process the request. 
 
Any ideas? 
 
> This will tell us what it is up to. 
 
I'm sorry I can't help much more. Can you give me more 
pointers on how to nail this down? 
 
Thanks! 
 
   Felipe Alfaro Solana 
 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze

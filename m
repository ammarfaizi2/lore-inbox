Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266716AbTB1O2X>; Fri, 28 Feb 2003 09:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267089AbTB1O2X>; Fri, 28 Feb 2003 09:28:23 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:8351 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S266716AbTB1O2V>; Fri, 28 Feb 2003 09:28:21 -0500
Message-ID: <20030228143811.9488.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Date: Fri, 28 Feb 2003 15:38:11 +0100
Subject: Re: anticipatory scheduling questions
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: Andrew Morton <akpm@digeo.com> 
Date: Fri, 28 Feb 2003 04:44:07 -0800 
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> 
Subject: Re: anticipatory scheduling questions 
 
> "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> wrote: 
> > 
> > I have done benchmark tests with Evolution under the following conditions: 
> > (times measured since the reply button is clicked until the message is 
> > opened)  
> >   
> > 2.4.20-2.54 -> 9s  
> > 2.5.63-mm1 w/Deadline -> 34s  
> > 2.5.63-mm1 w/AS -> 33s  
>  
> Well something has gone quite wrong there.   It sounds as if something in 
> the 2.5 kernel has broken evolution. 
>  
> Does this happen every time you reply to a message or just the first time? 
 
Only the first time. 
 
> And if you reply to a message, then quit evolution, then restart evolution 
> then reply to another message, does the same delay happen? 
>  
> The above tests will eliminate the IO system at least. 
 
OK, it seems to me there's an IO delay here: The first time I reply to a message, 
there is a continuous, steady and light disk load since I press the Reply button 
until the message appears. There are no pauses or delays. 
 
If I close the message window and then click Reply again, the window opens up 
almost immediately. Also, if I exit Evolution completely (shut it down and run "killev" 
to kill wombat and friends), and then open it up again, the Reply message procedure 
is also immediate. 
 
> If the delay is still there when all the needed datais in pagecache then 
> please run `vmstat 1' during the operation and send the part of the trace 
> from the period when the delay happens. 
 
Maybe I did not express myself correctly in my previous message: there are no such 
delays. Since the moment I click Reply for the very first time until the window opens up, 
there is no disk idle time. 
 
> I'd suggest that you launch evolution from the command line in an xterm so 
> you can watch for any diagnostic messages. 
 
I have done so: Evolution is a complex application with many interdependencies and is 
not very prone to launch diagnostic messages to the console. Anyways, I haven't seen 
any diagnostic message in the console. I still think there is something in the AS I/O scheduler 
that is not working at full read throughput. Of course I'm no expert. 
 
Thanks! 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze

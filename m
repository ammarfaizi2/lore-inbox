Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268112AbTB1UOg>; Fri, 28 Feb 2003 15:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268125AbTB1UOf>; Fri, 28 Feb 2003 15:14:35 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:6348 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S268112AbTB1UOe>; Fri, 28 Feb 2003 15:14:34 -0500
Message-ID: <20030228202437.20487.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Fri, 28 Feb 2003 21:24:37 +0100
Subject: TID/PID handling and possible rootkit
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello! 
 
This is a message forwarded from Red Hat's Phoebe (8.1) Linux 
Beta. It seems that some of us, when running "chkrootkit" rootkit 
checker, are getting consistent errors complaining that we have 
hidden processes from the "ps" command and "procfs". 
 
Can you please help us disguise what's happening? 
If so, keep reading :-) 
 
----- Original Message -----   
From: David McKellar <djmcke@yahoo.com>   
Date: Fri, 28 Feb 2003 09:33:15 -0800 (PST)    
To: phoebe-list@redhat.com   
Subject: Re: chkrootkit on phoebe   
   
> It says I have LKM also:   
>    
>   Checking `lkm'... You have    12 process hidden for readdir command   
>   You have    12 process hidden for ps command   
>   Warning: Possible LKM Trojan installed   
>    
> My system is on the net all the time so it could very well be infected.   
   
I have done some research and this is what I've found:   
   
Recompiling (get paranoid) chkrootkit creates a separate binary called 
"chkproc" that allows you to search for  hidden processes. Running 
"chkproc -v" on my system reveals this: 
   
ID  1364: not in readdir output   
PID  1364: not in ps output   
PID  1365: not in readdir output   
PID  1365: not in ps output   
PID  1366: not in readdir output   
PID  1366: not in ps output   
You have     3 process hidden for readdir command   
You have     3 process hidden for ps command   
   
My computer is behind a firewall that filters all ports < 1023 and I'm a 
very paranoic person, so I really doubt I have got infected by a trojan.  
   
In my case, I've found the culprit to be "Evolution": while running 
Evolution, there are 3 or more processes not  being displayed by the 
"ps" command, or even listed under "/proc., but they are accessible by 
"cd"-ing to them.  If I quit "Evolution", running "./chkproc -v" again does 
not generate those warnings. 
 
I think this is related to changes in PID/TID handling by recent kernels. 
If my memory serves me well, each thread of a process is given a 
unique ID (the Thread ID) which is assigned from the same pool as the 
PID, so, there was a time when you could see threads from the output 
of the "ps" command. I think this behaviour has changed, and now, you 
can't directly see threads by using "ps" or reading from "/proc". However, 
the TID number is still reserved from the same pool as PIDs, although 
it won't be listed in "/proc". For whatever reason it be, it seems that "procfs" 
still allows one to "cd" to the directory entry of a thread by using the 
Thread ID (TID), so this could be the culprit of the problem. Since 
"chkproc" tries "cd"-ing the hard way into all possible combinations of 
directories from within "/proc", "chkproc" is in fact "seeing" was should be 
hidden: the entries for threads. 
   
This problem is reproducible on 2.4.20-2.54 and 2.5.63-mm1.   
 
Can any kernel guru help us here? Am we right? Are we infected? 
 
Thanks! 
 
   Felipe Alfaro Solana 
 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze

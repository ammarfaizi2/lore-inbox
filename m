Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268128AbTB1Ubu>; Fri, 28 Feb 2003 15:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268130AbTB1Ubu>; Fri, 28 Feb 2003 15:31:50 -0500
Received: from crack.them.org ([65.125.64.184]:10935 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S268128AbTB1Ubt>;
	Fri, 28 Feb 2003 15:31:49 -0500
Date: Fri, 28 Feb 2003 15:41:58 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TID/PID handling and possible rootkit
Message-ID: <20030228204158.GA26610@nevyn.them.org>
Mail-Followup-To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	linux-kernel@vger.kernel.org
References: <20030228202437.20487.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030228202437.20487.qmail@linuxmail.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David's analysis is pretty much right on.

On Fri, Feb 28, 2003 at 09:24:37PM +0100, Felipe Alfaro Solana wrote:
> Hello! 
>  
> This is a message forwarded from Red Hat's Phoebe (8.1) Linux 
> Beta. It seems that some of us, when running "chkrootkit" rootkit 
> checker, are getting consistent errors complaining that we have 
> hidden processes from the "ps" command and "procfs". 
>  
> Can you please help us disguise what's happening? 
> If so, keep reading :-) 
>  
> ----- Original Message -----   
> From: David McKellar <djmcke@yahoo.com>   
> Date: Fri, 28 Feb 2003 09:33:15 -0800 (PST)    
> To: phoebe-list@redhat.com   
> Subject: Re: chkrootkit on phoebe   
>    
> > It says I have LKM also:   
> >    
> >   Checking `lkm'... You have    12 process hidden for readdir command   
> >   You have    12 process hidden for ps command   
> >   Warning: Possible LKM Trojan installed   
> >    
> > My system is on the net all the time so it could very well be infected.   
>    
> I have done some research and this is what I've found:   
>    
> Recompiling (get paranoid) chkrootkit creates a separate binary called 
> "chkproc" that allows you to search for  hidden processes. Running 
> "chkproc -v" on my system reveals this: 
>    
> ID  1364: not in readdir output   
> PID  1364: not in ps output   
> PID  1365: not in readdir output   
> PID  1365: not in ps output   
> PID  1366: not in readdir output   
> PID  1366: not in ps output   
> You have     3 process hidden for readdir command   
> You have     3 process hidden for ps command   
>    
> My computer is behind a firewall that filters all ports < 1023 and I'm a 
> very paranoic person, so I really doubt I have got infected by a trojan.  
>    
> In my case, I've found the culprit to be "Evolution": while running 
> Evolution, there are 3 or more processes not  being displayed by the 
> "ps" command, or even listed under "/proc., but they are accessible by 
> "cd"-ing to them.  If I quit "Evolution", running "./chkproc -v" again does 
> not generate those warnings. 
>  
> I think this is related to changes in PID/TID handling by recent kernels. 
> If my memory serves me well, each thread of a process is given a 
> unique ID (the Thread ID) which is assigned from the same pool as the 
> PID, so, there was a time when you could see threads from the output 
> of the "ps" command. I think this behaviour has changed, and now, you 
> can't directly see threads by using "ps" or reading from "/proc". However, 
> the TID number is still reserved from the same pool as PIDs, although 
> it won't be listed in "/proc". For whatever reason it be, it seems that "procfs" 
> still allows one to "cd" to the directory entry of a thread by using the 
> Thread ID (TID), so this could be the culprit of the problem. Since 
> "chkproc" tries "cd"-ing the hard way into all possible combinations of 
> directories from within "/proc", "chkproc" is in fact "seeing" was should be 
> hidden: the entries for threads. 
>    
> This problem is reproducible on 2.4.20-2.54 and 2.5.63-mm1.   
>  
> Can any kernel guru help us here? Am we right? Are we infected? 
>  
> Thanks! 
>  
>    Felipe Alfaro Solana 
>  
> -- 
> ______________________________________________
> http://www.linuxmail.org/
> Now with e-mail forwarding for only US$5.95/yr
> 
> Powered by Outblaze
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

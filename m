Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268260AbUHKVqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268260AbUHKVqe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 17:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268241AbUHKVqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 17:46:07 -0400
Received: from mail1.srv.poptel.org.uk ([213.55.4.13]:11486 "HELO
	mail1.srv.poptel.org.uk") by vger.kernel.org with SMTP
	id S268259AbUHKVpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 17:45:16 -0400
Message-ID: <411A92EC.6090609@phonecoop.coop>
Date: Wed, 11 Aug 2004 22:43:08 +0100
From: Alan Jenkins <sourcejedi@phonecoop.coop>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Wakko Warner <wakko@animx.eu.org>
Subject: Re: cd burning: kernel / userspace?
References: <41189AA2.3010908@phonecoop.coop> <20040810220528.GA17537@animx.eu.org> <4119DFB0.6050204@phonecoop.coop> <20040811164109.GA18761@animx.eu.org> <411A89BB.60505@phonecoop.coop> <20040811213322.GA19908@animx.eu.org>
In-Reply-To: <20040811213322.GA19908@animx.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:

>Please keep me CC
>
>  
>
>>A script would be cool, but dd doesn't do the memory locking and real 
>>time priority stuff.  I don't know how important this is - how old your 
>>hardware would have to be for you to get "coasters" (buffer underun) 
>>without it.
>>    
>>
>
>Agreed, however, I was attempting to make a point by saying dd.
>
>  
>
>>Theres an option in cdrecord to fixate an arbitrary disk (one without a 
>>TOC for whatever reason), and one not to fixate the disk you're writing, 
>>so it looks like fixation could and should be done on demand using an 
>>ioctl.  You'd also need ioctls to deal with multiple sessions.
>>    
>>
>
>Already thought of this.  But how to deal with it, I don't know.
>
>  
>
>>I think most people would want a cdrwtool that basically pretends to be 
>>cdrecord (in some ways ;), because thats the most intuitive way to do it 
>>- even if you can do everything you want to with cdrwtool for the ioctls 
>>and dd for the data.
>>    
>>
>
>That did come to mind, as long as I don't have to use dev=x,y,z (joerg you
>listening?  Another user steps up to say he hates it =)    heheh.
>
>  
>
>>I've definitely underestimated the problems with my idea, and I can't 
>>see any tangible benefits which couldn't be obtained by hacking
>>    
>>
>
>I can, like someone else specified.  Unlike windows, linux users can put
>whatever filesystem (or just plain data) on a cd they choose.
>
>They wanted to specify their cdrw to send stuff directly to it and change
>cds.  Something like this (so long as the driver supports it too):
>
>cdrwtool /dev/scd0 -ejectonclose -fixateonclose
>	note could possibly do -dao with a fixed size.
>	also, I don't know dump's options so I'm improvising
>dump -D /dev/scd0 -B 700MB /home
>
>When dump fills 700mb, it will close and await the user.  Since the driver
>was told to fixate and eject on close, the cd comes out ready.  I understand
>buffer underruns here and for starters, underruns aren't part of this
>picture, it can come later (ie after proof of concept)
> 
>  
>
>>cdrecord.  Idealistically, its the right thing to do - but in practice 
>>its unessecary, I'm not up to the job, and its not attractive enough for 
>>someone to pick up.  After packet writing is seamlessly merged into the 
>>uniform cdrom driver it might start looking more important, and I might 
>>have learnt enough to at least implement a proof of concept.  I'm still 
>>interested in hashing out more details and potential benefits.
>>    
>>
>
>Frankly, I have found that growisofs is awkward to use.  I could hack it to
>be better suited for what I wanted to do (I can't pipe data into it.  I used
>to do mkisofs on one machine, send the data over the network and burn at the
>same time.)  However, it's not as bad as dev=x,y,z
>
>For me, if this were implemented in kernel, I could do this:
>nail:~> mkisofs -r -no-pad /80g/debian/x/vol200 | \
>	ssh vegeta 'cat > /dev/scd0'
>
>(nail is a disk server, vegeta is the box with the burner on /dev/scd0,
>that's my current setup)
>
>  
>
Sorry, I'm not very good at this list / person CC stuff.  I sent a reply 
to Valdis.Kletnieks@vt.edu, but forgot to CC to list.  Contents as follows:

I'm not sure this is necessary.  Can't you just do:

# dump -0 -B 700000 -u -z3 /home -f -| cdrecord /dev/hdb -

dump and cdrecord allow you to use "-" as a filename to indicate that 
output shoud be written to stdout and input should be read from stdin 
respectively.

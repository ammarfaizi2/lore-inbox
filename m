Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270906AbTGVVxg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 17:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270910AbTGVVxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 17:53:36 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:39954 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S270906AbTGVVxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 17:53:34 -0400
Message-ID: <3F1DB75E.1050906@kolumbus.fi>
Date: Wed, 23 Jul 2003 01:14:54 +0300
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>,
       Jason Baron <jbaron@redhat.com>, vda@port.imtp.ilyichevsk.odessa.ua,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pivot_root seems to be broken in 2.4.21-ac4
References: <Pine.LNX.4.44.0307221331090.2754-100000@dhcp64-178.boston.redhat.com>	 <1058895650.4161.23.camel@dhcp22.swansea.linux.org.uk>	 <3F1D7C80.6020605@gibraltar.at> <1058904025.4160.30.camel@dhcp22.swansea.linux.org.uk>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 23.07.2003 01:10:05,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 23.07.2003 01:09:28,
	Serialize complete at 23.07.2003 01:09:28
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/sbin/init used to start up with files->count > 1 and does 
close(0);close(1);close(2); -> kernel thread fds close.

Now with unshare_files() and init's files->count ==1 the kernel threads  
/dev/console fds remain open. But one could ask of course so what :)

--Mika


Alan Cox wrote:

>>If it is not expected behaviour that the kernel processes no longer 
>>close their fds open an pivot_root, then I'd like to debug this (is my 
>>use of pivot_root correct or am I doing something wrong here ?). I will 
>>try with vanilla 2.4.21 now and see how that goes (or should I rather 
>>try 2.4.22-pre7 ?).
>>    
>>
>
>2.4.22pre7 has the unshare_files fix - its a security fix.
>
>It should not have changed the behaviour so I'm very interested to know if
>that specific patch set changes the behaviour and precisely what your code
>is doing
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>



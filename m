Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbSLZJSd>; Thu, 26 Dec 2002 04:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262813AbSLZJSd>; Thu, 26 Dec 2002 04:18:33 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:26285 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S262808AbSLZJSc>; Thu, 26 Dec 2002 04:18:32 -0500
Message-ID: <20021226092641.12371.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: akpm@digeo.com, ciarrocchi@linuxmail.org
Cc: vda@port.imtp.ilyichevsk.odessa.ua, conma@kolivas.net,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org
Date: Thu, 26 Dec 2002 17:26:41 +0800
Subject: Re: Poor performance with 2.5.52, load and process in D state
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@digeo.com>

> Paolo Ciarrocchi wrote:
> > 
> > Hi Andrew/Rik/Con/all
> > 
> > Andrew, I promised you to run a few tests
> > using osdb (www.osdb.org with 40M of data)against both
> > 2.4.19 and 2.5.52 booting the kernel with the
> > mem=XXM paramter.
> > 
> > I also played with the /proc/sys/vm/swappiness
> > parameter, I've ran all the tests with the standard
> > swappiness value (60), with 80 and 100.
> > 
> > 100 means the 2.4 behaviour, isn't it ?
> 
> Not really.  swappiness=100 is strict LRU, treating pagecache and
> mapped-into-process-memory pages identically.  Smaller values will
> make the kernel prefer to preserve mapped-into-process-memory.
> 
> > Looking at the results it seems that the "standard"
> > value is too low, probably 80 is the best one.
> > What do you think ?
> 
> I would agree with that.
>  
> > ...
> > 
> > 2.4.19  all     x               778.65 seconds  (0:12:58.65)
> > 2.5.52  all     60              768.98 seconds  (0:12:48.98)
> > 2.5.52  all     80              770.43 seconds  (0:12:50.43)
> > 2.5.52  all     100             771.76 seconds  (0:12:51.76)
> 
> Only 1% difference.  On my 4xPIII with mem=128M, 2.4.20-pre2 took
> 1080.55 seconds and 2.5.52-mm3 took 991.03.  That's 9% faster, and
> from the profile:
> 
> c010a858 system_call                                 192   4.3636
> c011e518 current_kernel_time                         201   3.3500
> c012cdbc __generic_file_aio_read                     214   0.4652
> c012bba0 kallsyms_lookup                             219   0.8295
> c012ccec file_read_actor                             230   1.1058
> c0145abc fget                                        318   4.1842
> c01d3ed4 radix_tree_lookup                           384   3.8400
> c0144be0 vfs_read                                    409   1.3279
> c01315f4 check_poison_obj                            695   7.8977
> c012c964 do_generic_mapping_read                    1007   1.1988
> c01d7ae0 __copy_user_intel                         34130 213.3125
> c0108a58 poll_idle                                299231 3562.2738
> 
> it appears that this benefit came from the special usercopy code.
> What sort of CPU are you using?

It is a PIII@800.

Ciao,
      Paolo
 

-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze

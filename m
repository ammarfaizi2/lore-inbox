Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbWISAI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbWISAI1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 20:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWISAI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 20:08:26 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:35770 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030318AbWISAI0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 20:08:26 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user
	memory)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Pavel Emelianov <xemul@openvz.org>
Cc: balbir@in.ibm.com, Rik van Riel <riel@redhat.com>,
       Srivatsa <vatsa@in.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Kirill Korotaev <dev@sw.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <450E9327.8020004@openvz.org>
References: <44FD918A.7050501@sw.ru>	<44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru>	<44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra>	<45011CAC.2040502@openvz.org>
	 <1157730221.26324.52.camel@localhost.localdomain>
	 <4501B5F0.9050802@in.ibm.com> <450508BB.7020609@openvz.org>
	 <4505161E.1040401@in.ibm.com> <45051AC7.2000607@openvz.org>
	 <1158000590.6029.33.camel@linuxchandra>	<45069072.4010007@openvz.org>
	 <1158105488.4800.23.camel@linuxchandra>	<4507BC11.6080203@openvz.org>
	 <1158186664.18927.17.camel@linuxchandra>	<45090A6E.1040206@openvz.org>
	 <1158277364.6357.33.camel@linuxchandra>	<450A5325.6090803@openvz.org>
	 <450A6A7A.8010102@sw.ru> <450A8B61.7040905@openvz.org>
	 <450E828B.2000901@in.ibm.com>  <450E9327.8020004@openvz.org>
Content-Type: text/plain
Organization: IBM
Date: Mon, 18 Sep 2006 17:08:20 -0700
Message-Id: <1158624500.6536.20.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-18 at 16:37 +0400, Pavel Emelianov wrote:
> Balbir Singh wrote:
> 
> [snip]
> >
> > The program (calculate_limits()) listed on the website does not work for
> > the following case
> >
> > N=2;
> > R=100;
> > g[2] = {30, 30};
> >
> >
> > The output is -10 and -10 for the limits
> >
> > For
> >
> > N=3;
> > R=100;
> > g[3] = {30, 30, 10};
> >
> > I get -70, -70 and -110 as the limits
> >
> > Am I interpreting the parameters correctly? Or the program is broken?
> >
> 
> Program on site is broken. Thanks for noticing:
> 
> $ gcc guar.c -o guar
> $ ./guar 30 30
> guar lim
>   30  70 ( 70/1)
>   30  70 ( 70/1)
> $ ./guar 30 30 10
> guar lim
>   30  45 ( 90/2)
>   30  45 ( 90/2)
>   10  25 ( 50/2)

I am confused. Are you changing the parameters on how the user want the
groups to be controlled.

They want the resource usage to be between 30 and 70, but you change it
to be 30-45. 

> 
> 
> To stop future "errors" remember that this is a simplified program that
> considers guarantees to be <= 100%, sum of guarantees to be <= 100% etc.
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------



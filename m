Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263687AbUEKV2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUEKV2b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 17:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263685AbUEKV1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 17:27:33 -0400
Received: from CPE0000c02944d6-CM00003965a061.cpe.net.cable.rogers.com ([69.193.74.215]:3289
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id S263665AbUEKVZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 17:25:59 -0400
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
From: John McCutchan <ttb@tentacle.dhs.org>
To: carbonated beverage <ramune@net-ronin.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040511202812.GA5737@net-ronin.org>
References: <1084152941.22837.21.camel@vertex>
	 <20040510021141.GA10760@taniwha.stupidest.org>
	 <1084227460.28663.8.camel@vertex>
	 <20040511024701.GA19489@taniwha.stupidest.org>
	 <1084278001.1225.9.camel@vertex>
	 <20040511124647.GE17014@parcelfarce.linux.theplanet.co.uk>
	 <20040511190228.GA12609@tentacle.dhs.org>
	 <20040511202812.GA5737@net-ronin.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1084310938.2973.5.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 11 May 2004 17:28:58 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-11 at 16:28, carbonated beverage wrote:
> On Tue, May 11, 2004 at 03:02:31PM -0400, John McCutchan wrote:
> > >From a quick glance at someone elses implementation of it, I plan on
> > walking up the dentries and checking at each level if a watcher on that
> > level is interested in events from subdirectories. Is this good practice in
> > the kernel?
> 
> Curious, why is it being implemented in this fashion instead of broadcasting
> it over a netlink socket?

I think this would be a security issue. How would you control access to
the events so that you can't watch directories you shouldn't be able to
access?

> As for the directory heirarchy watching, does that mean the user can do:
> <process 1>   <process 2>
>               while : ; do mkdir a ; cd a ; done
>     .... wait 10 seconds ....
> listen to a/
> 
> What's the kernel going to do then?  Hopefully, you don't mean you'll
> be crawling down the entire chain each and every time...

You are right this would be a big problem. I am not sure the best way to
handle events from sub-directories. 

John

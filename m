Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267341AbSLEQHG>; Thu, 5 Dec 2002 11:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267342AbSLEQHF>; Thu, 5 Dec 2002 11:07:05 -0500
Received: from host194.steeleye.com ([66.206.164.34]:39952 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267341AbSLEQHF>; Thu, 5 Dec 2002 11:07:05 -0500
Message-Id: <200212051614.gB5GEUN02667@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Patrick Mochel <mochel@osdl.org>
cc: Greg KH <greg@kroah.com>, James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BKPATCH] bus notifiers for the generic device model 
In-Reply-To: Message from Patrick Mochel <mochel@osdl.org> 
   of "Wed, 04 Dec 2002 21:50:25 CST." <Pine.LNX.4.33.0212042135420.924-100000@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 05 Dec 2002 10:14:30 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mochel@osdl.org said:
> I don't see how your patch adresses chaining; there is only one
> notifier  per bus type. 

Well, you can do it by storing the pointer privately and hijacking it.  
However, I think we'd use the existing kernel notifier chain stuff for that if 
it is valuable.

> Along they way, we've found several things stand in the way of making
> this  a smooth transition, so the plan is to stick with the bus
> intermediaries  until the infrastructure matures enough to tackle
> those problems more  easily.  

I'm happy with keeping probe and remove in the bus specific driver template 
and having the <bustype>_add_driver install generic device probe and remove 
routines to handle these cases.  My point was that the docs implied I should 
use the generic driver probe and remove routines, which I can't without some 
type of functionality like this.

If you envisage us never eliminating the driver specific probe and remove 
routines, I'm happy.  I'm less happy if there will come a day when I have to 
revisit all the converted drivers to do the elimination.

James



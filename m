Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbTEMQpp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbTEMQpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:45:41 -0400
Received: from air-2.osdl.org ([65.172.181.6]:6334 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262256AbTEMQp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:45:28 -0400
Date: Tue, 13 May 2003 09:58:34 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Alex Riesen <alexander.riesen@synopsys.COM>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.86+: sizes of almost all files in sysfs are 4k?
In-Reply-To: <20030423082727.GE890@riesen-pc.gr05.synopsys.com>
Message-ID: <Pine.LNX.4.44.0305130954390.9816-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Apr 2003, Alex Riesen wrote:

> This confuses some applications (i.e., the midnight commander).
> 
> Was this intended?

Yes. This was done at the request of one annoying konqueror user that 
wanted it to be smart enough to define a default handler for the text 
files, so he could click on it and get a preview of the contents in the 
sidebar. 

[ I know it's a pretty poor reason to add a feature, but I caved anyway. ]

> If the size is not simple/possible to calculate, maybe using 0
> would be an option for the cases where the size doesn't carry
> any information (like in procfs)?

It was 0 before, which works fine for cat(1). By hardcoding the size, some 
bugs are exposed, since the size is reset for some reason when you try to 
open the file for writing, even if open(2) returns an error. 

Ideally, we should be calculating the size, and using that. However, that 
would involve keeping type information about the file around, which we 
don't currently do. Research/patches in this area would be greatly 
appreciated. 


	-pat


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUDIRdn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 13:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbUDIRdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 13:33:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:35740 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261498AbUDIRd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 13:33:26 -0400
Date: Fri, 9 Apr 2004 10:31:58 -0700
From: Greg KH <greg@kroah.com>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Jean Delvare <khali@linux-fr.org>,
       LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6] Rework memory allocation in i2c chip drivers
Message-ID: <20040409173158.GC15820@kroah.com>
References: <20040403191023.08f60ff1.khali@linux-fr.org> <20040403202042.GA3898@sirius.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040403202042.GA3898@sirius.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2004 at 12:20:42AM +0400, Sergey Vlasov wrote:
> Hello!
> 
> > Some times ago, Ralf Roesch reported that the memory allocation scheme
> > used in the i2c eeprom driver was causing trouble on MIPS architecture:
> > 
> > http://archives.andrew.net.au/lm-sensors/msg07233.html
> > 
> > The cause of the problems is that we do allocate two structures with a
> > single kmalloc, which breaks alignment. This doesn't seem to be a
> > problem on x86, but is on mips and probably on other architectures as
> > well. It happens that all other chip drivers work the same way too, so
> > they all would need to be fixed.
> 
> Instead of splitting one kmalloc in two, it would also be possible to
> add a "struct i2c_client client" field to each of the *_data
> structures - the compiler should align all fields appropriately.
> Probably this way will result in less changes to the code (and also
> less labels and less error paths).
> 
> Example patch for lm75 (untested):

I like this version a lot better.  It's simpler and if we do this, we
can easily switch to the proper refcount handling of the i2c_client
structures like we should do in 2.7.

Jean, care to redo your patch in this form?

thanks,

greg k-h

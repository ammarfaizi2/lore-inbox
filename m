Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbUCZUqe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 15:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUCZUpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 15:45:42 -0500
Received: from pop.gmx.de ([213.165.64.20]:44232 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261210AbUCZUp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 15:45:26 -0500
X-Authenticated: #271361
Date: Fri, 26 Mar 2004 21:45:07 +0100
From: Edgar Toernig <froese@gmx.de>
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: davem@redhat.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH] Consolidate multiple implementations of jiffies-msecs
 conversions.
Message-Id: <20040326214507.0af7c06b.froese@gmx.de>
In-Reply-To: <Pine.LNX.4.58.0403261007370.6718@localhost.localdomain>
References: <Pine.LNX.4.58.0403251142110.3037@localhost.localdomain>
	<20040326014403.39388cb8.froese@gmx.de>
	<Pine.LNX.4.58.0403261007370.6718@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sridhar Samudrala wrote:
> 
> On Fri, 26 Mar 2004, Edgar Toernig wrote:
> 
> > Sridhar Samudrala wrote:
> > >
> > >[...]
> > > -#define MSECS(ms)  (((ms)*HZ/1000)+1)
> > > -return (((ms)*HZ+999)/1000);
> > > +return (msecs / 1000) * HZ + (msecs % 1000) * HZ / 1000;
> >
> > Did you check that all users of the new version will work correctly
> > with your rounding?  Explicit round-up of delays is often required,
> > especially when talking to hardware...
>[...] 
> I guess you are referring to cases when HZ < 1000(ex: 100) and msecs is
> less than 10. In those cases, the new version returns 0, whereas some of the
> older versions return 1.

Exactly - but not only <10.  Any value that is not exactly representable
in jiffies.  I.e. for a delay of 15ms one has to wait 2 jiffies on a 100HZ
system.  Your version would give 1 jiffy = 10ms -- too short.

Ciao, ET.

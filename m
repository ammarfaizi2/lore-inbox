Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263020AbUFJUuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbUFJUuo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 16:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUFJUun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 16:50:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:26339 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263020AbUFJUul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 16:50:41 -0400
Date: Thu, 10 Jun 2004 13:48:55 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: greg@kroah.com, viro@parcelfarce.linux.theplanet.co.uk,
       sensors@stimpy.netroedge.com, rtjohnso@eecs.berkeley.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Finding user/kernel pointer bugs [no html]
Message-Id: <20040610134855.051cbb5a.rddunlap@osdl.org>
In-Reply-To: <20040610202803.GA3673@mars.ravnborg.org>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu>
	<20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk>
	<20040610165821.GB32577@kroah.com>
	<20040610191004.GA1661@kroah.com>
	<20040610191359.GJ12308@parcelfarce.linux.theplanet.co.uk>
	<20040610193207.GA1904@kroah.com>
	<20040610202803.GA3673@mars.ravnborg.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2004 22:28:03 +0200 Sam Ravnborg wrote:

| On Thu, Jun 10, 2004 at 12:32:08PM -0700, Greg KH wrote:
| > On Thu, Jun 10, 2004 at 08:14:00PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
| > > On Thu, Jun 10, 2004 at 12:10:04PM -0700, Greg KH wrote:
| > > > @@ -170,8 +170,11 @@
| > > >  static int DIV_TO_REG(int val)
| > > >  {
| > > >  	int answer = 0;
| > > > -	while ((val >>= 1))
| > > > +	val >>= 1;
| > > > +	while (val) {
| > > >  		answer++;
| > > > +		val >>= 1;
| > > > +	}
| > > >  	return answer;
| > > 
| > > That's less readable than the original...
| > 
| > Hm, so we should ignore the sparse warning about the original then?
| 
| What about:
| 
| 	while ((val >>= 1) != 0) {
| 		...
| 
| Readable and sparse clean (I suppose).

Exactly what I would suggest, based on a few days of doing these.
Maintains the readability of the code much better than the other
change did...

--
~Randy

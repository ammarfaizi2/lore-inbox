Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbUFJUVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUFJUVI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 16:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUFJUVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 16:21:08 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:18440 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262951AbUFJUVF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 16:21:05 -0400
Date: Thu, 10 Jun 2004 22:28:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg KH <greg@kroah.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, sensors@stimpy.netroedge.com,
       "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding user/kernel pointer bugs [no html]
Message-ID: <20040610202803.GA3673@mars.ravnborg.org>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	viro@parcelfarce.linux.theplanet.co.uk, sensors@stimpy.netroedge.com,
	"Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu> <20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk> <20040610165821.GB32577@kroah.com> <20040610191004.GA1661@kroah.com> <20040610191359.GJ12308@parcelfarce.linux.theplanet.co.uk> <20040610193207.GA1904@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040610193207.GA1904@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 12:32:08PM -0700, Greg KH wrote:
> On Thu, Jun 10, 2004 at 08:14:00PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > On Thu, Jun 10, 2004 at 12:10:04PM -0700, Greg KH wrote:
> > > @@ -170,8 +170,11 @@
> > >  static int DIV_TO_REG(int val)
> > >  {
> > >  	int answer = 0;
> > > -	while ((val >>= 1))
> > > +	val >>= 1;
> > > +	while (val) {
> > >  		answer++;
> > > +		val >>= 1;
> > > +	}
> > >  	return answer;
> > 
> > That's less readable than the original...
> 
> Hm, so we should ignore the sparse warning about the original then?

What about:

	while ((val >>= 1) != 0) {
		...

Readable and sparse clean (I suppose).

	Sam

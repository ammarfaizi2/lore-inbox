Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbVCBRtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVCBRtX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 12:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVCBRtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 12:49:17 -0500
Received: from web53708.mail.yahoo.com ([206.190.37.29]:12465 "HELO
	web53708.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262393AbVCBRqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 12:46:42 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=SuU0HqVSsDp1lal87EMcz+nqa+JnbhOvtWVMzB4W7TSy/wyJlSYHRtIlv9HeoR1GYneDo/2nrp2ji5R5E0qbIJI/CzPdEDsECjV6rwZD/X7jgMS53qimMF6Qc86x+Zu61hVx9c7l6eCXzCY41KEE2b2qrIGiSVGsjLsBKrL/tbI=  ;
Message-ID: <20050302174637.77861.qmail@web53708.mail.yahoo.com>
Date: Wed, 2 Mar 2005 09:46:37 -0800 (PST)
From: Muthian Sivathanu <muthian_s@yahoo.com>
Subject: Re: ext3 journal commit performance
To: linux-os@analogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0503021237110.5955@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > I have a question on ext3 journal commit code. 
> When a
> > transaction is committed in the ordered mode, ext3
> > first issues the data writes, waits for them to
> > finish, then issues the journal writes, waits for
> them
> > to finish, and then writes out the commit record.
> >
> > It appears that the first wait (for the data
> blocks)
> > is unnecessary because all that is required is
> that
> 
> Wrong. If you perform two buffered writes
> back-to-back
> will you guarantee that they are both on the disk
> when
> the second finishes? Not on your life! They can
> (read will)
> be reordered depending upon the closest seek. So it
> is
> mandatory that one wait to make sure that both
> writes
> occur in order.
> 
> 

Sorry if I was unclear.  I did not say that waiting
for the metadata will guarantee commit of the data as
well.  My point is you can wait for both of them
_together_ after issuing both of them to disk, instead
of serializing them at the issue stage itself.

Muthian

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

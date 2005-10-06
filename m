Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbVJFSXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVJFSXu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 14:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVJFSXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 14:23:50 -0400
Received: from web33007.mail.mud.yahoo.com ([68.142.206.71]:9302 "HELO
	web33007.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751295AbVJFSXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 14:23:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=r4/UDzJezYUWovpKyd10x7MngXS3GHmlh/qgDWq5JEtH7MT2uCOTLf3wGvdQrS0+RhwRrRLUeHLEgNBdO5VGl6eXa+nN2Yyb++pipwswFOsY3y+Vi5LSqJ4HASxgbGpJJ+QfIhZLeR+B1ZqWuvixAUEnTovtTPpPXWNKubVUzwk=  ;
Message-ID: <20051006182349.7430.qmail@web33007.mail.mud.yahoo.com>
Date: Thu, 6 Oct 2005 19:23:48 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [PATCH/RFC 1/2] simple SPI framework
To: David Brownell <david-b@pacbell.net>, vwool@ru.mvista.com,
       rmk+lkml@arm.linux.org.uk
Cc: stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       pavel@ucw.cz, linux-kernel@vger.kernel.org, dpervushin@gmail.com,
       basicmark@yahoo.com
In-Reply-To: <20051005143946.7D9C9EE8EC@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- David Brownell <david-b@pacbell.net> wrote:

> > > >+/* Suspend/resume in "struct device_driver" don't really need that
> > > >+ * strange third parameter, so we just make it a constant and expect
> > > >+ * SPI drivers to ignore it just like most platform drivers do.
> > > >+ *
> > >
> > > So you just ignored my letter on that subject :(
> > > The fact that you don't need it doesn't mean that other people won't.
> > > The fact that there's no clean way to suspend USB doesn't mean that 
> > > there shouldn't be one for SPI.
> >
> > The third parameter is obsolete and should only be used to select _one_
> > of the tree suspend calls you will get.
> 
> Vitaly ... comments from Russell and Pavel both addresses your comments
> about that obsolete parameter.  What letter?  The one I remember was
> one responding to Mark Underwood (?) where you complained about issuing
> three calls for one suspend event.  You can't have it both ways!!
> Either that parameter should be used in the documented way (call the
> suspend method three times, one right after another) or it should be used
> more sanely (parameter is constant.

Yes, that was in reply to my SPI subsystem patch set (in which Vitaly didn't like the fact that I
call suspend/resume 3 times) and then in the same thread (in answer to David's response of
dropping this as he didn't think anyone would mind this) Vitaly said that you can't do this.

> 
> USB can suspend just fine, thank you, though starting with 2.6.12 some
> bugs seem to have crept in; fixes are in the 2.6.15 prepatchces.
> 
> 
> > Any additional suspend calls should _not_ create extra usage of this
> > parameter.  It's a left over from Pat's first driver model incarnation
> > which is specific to the platform device drivers.  (Mainly it exists
> > because no one can be bothered to clean it up.)
> 
> Most folk who've considered the question would like to see it go away.
> Except ... making sure every driver in a few dozen architectures still
> builds after removing that parameter is more than the usual amount of
> janitorial work!
> 
> Progress could start by updating Documentation/driver-model/driver.txt to
> say "don't test that parameter", reducing future confusion on this point.

Thank you! That would clear up this confusion :).

> 
> - Dave
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
___________________________________________________________ 
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com

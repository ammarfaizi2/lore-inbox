Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWDFQxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWDFQxK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 12:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWDFQxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 12:53:09 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:43342 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932192AbWDFQxI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 12:53:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fOVjoEtjw5fqAJSwtgkWegsAI4P5KhCPs1VAVs+BnXo0HWz+ICX9AkzIbn2lQT5emNVFhWOItZDAXolz12seVyPZDq3jszzSTvG1+xIf+giFiMC1AHU7Oz9LD3PVdKynKKHUygLEtrc1ZSmPATVbLN86sXTUJnclVer4a0VD+ww=
Message-ID: <493eee610604060953jcfdd2b6wdf773f4fb828aafa@mail.gmail.com>
Date: Thu, 6 Apr 2006 18:53:07 +0200
From: "Janos Farkas" <chexum+dev@gmail.com>
To: "David Daney" <ddaney@avtrex.com>
Subject: Re: Broadcast ARP packets on link local addresses (Version2).
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       pgf@foxharp.boston.ma.us, freek@macfreek.nl
In-Reply-To: <44353F36.9070404@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <17460.13568.175877.44476@dl2.hq2.avtrex.com>
	 <priv$efbe06144502$2d51735f79@200604.gmail.com>
	 <44353F36.9070404@avtrex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/06, David Daney <ddaney@avtrex.com> wrote:
> Janos Farkas wrote:
> > Shouldn't it
> > be more correct to not depend on the ip address of the used network,
> > but to use the "scope" parameter of the given address?

> RFC 3927 specifies the Ethernet arp broadcast behavior for only
> 169.254.0.0/16.  Presumably you could set the scope parameter to local
> for addresses outside of that range or even for protocols other than
> Ethernet.  Since broadcasting ARP packets usually adversely effects
> usable network bandwidth, we should probably only do it where it is
> absolutely required.  The overhead of testing the value required by the
> RFC is quite low (3 machine instructions on i686 is the size of the
> entire patch), so using some proxy like the scope parameter would not
> even be a performance win.

Indeed, I just have a bad feeling about hardwiring IP addresses this deep.

The problems with "my" idea would be, summarily, after a day:

Q: Is there are reason to use broadcast ARP semantics for other IP
address ranges?
A: Maybe, but no RFC defines that.
Q: Is there are reason to NOT use broadcast ARP semantics for the
defined IP address ranges?
A: Maybe, but the RFC is against it.
Q: Is there a reason to expect people (and tools) to use/define scopes?
A: Probably, but it's still uncommon practice :)  I mean, how many of
us have 192.168.x.x addresses with "global" scope? I know I do.

I'm still in a losing position :)

Janos

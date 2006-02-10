Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWBJOul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWBJOul (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWBJOul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:50:41 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:12262 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751264AbWBJOul convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:50:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nMVKroNkCGXXASPgfYFqTqSlTI5pBkDTS8kdt+TltzofmcT/VeOrMyAnu+bOIVFah+qVVBppwKYbYH4urgd/OtvYysgBhGMHsgMMog2anFElIYANlgLaAUcGGjuDV73jRkWjcYb8Zp6fFfwSi0lR+sfBLThKUklZOLW8/8vWYtk=
Message-ID: <728201270602100650q22938b88x237b8fb043c82408@mail.gmail.com>
Date: Fri, 10 Feb 2006 08:50:38 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: RSS Limit implementation issue
Cc: linux mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <1139526447.6692.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <728201270602091310r67a3f2dcq4788199f26a69528@mail.gmail.com>
	 <1139526447.6692.7.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

>
> That is what I would expect. Or perhaps even allowing the process to
> exceed the RSS but using the RSS limit as a swapper target so that the
> process is victimised early. No point forcing swapping and the RSS limit
> when there is free memory, only where the resource is contended ..
>
>

So we will need some kind of free memory threshold . If free memory is
more than it than we can let RSS exceed & scheduler can also schedule
it in this situation but not if free memory is less than the
threshhold. Also we need to figure out a way for swapper to target
pages based on RSS limit. One possible  disadvantage I can think is
that  as the swapper swaps out a page based on RSS limit , the
process's rss will become within the rss limit & then scheduler will
schedule this process again & hence possibly same page might have to
be brought in. This may cause increase in swapping. What do you think
how much realistic is this scenario?

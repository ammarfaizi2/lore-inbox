Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291823AbSBIABi>; Fri, 8 Feb 2002 19:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291890AbSBIAB3>; Fri, 8 Feb 2002 19:01:29 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:37710 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S291823AbSBIABT>; Fri, 8 Feb 2002 19:01:19 -0500
Date: Fri, 8 Feb 2002 19:01:17 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: patch: aio + bio for raw io
Message-ID: <20020208190117.A12959@redhat.com>
In-Reply-To: <20020208025313.A11893@redhat.com> <200202082107.g18L7wx26206@eng2.beaverton.ibm.com> <20020208171327.B12788@redhat.com> <200202082254.g18Mspq08299@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200202082254.g18Mspq08299@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Feb 08, 2002 at 02:54:51PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 02:54:51PM -0800, Linus Torvalds wrote:
> bio can handle arbitrarily large IO's, BUT it can never split them. 

I agree that it should not split ios, but it should not needlessly limit 
the size of them either -- that choice should be left to individual 
drivers.

...
> If you are in the small small _small_ minority care about 4MB requests,
> you should build the infrastructure not to make drivers split them, but
> to build up a list of bio's and then submit them all consecutively in
> one go.
> 
> Remember: checking the limits as you build stuff up is easy, and fast. 
> 
> So you should make sure that you never EVER cause anybody to want to
> split a bio. 

Yup.  What we need is an interface for getting the max size of an io -- 
I can see this being needed for filesystems, char devices, network drivers, 
basically anything that we can do aio/"direct" io on.  Given that, I can 
put the split / pipelining code into the generic layer.

		-ben

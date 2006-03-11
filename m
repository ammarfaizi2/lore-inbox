Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWCKLw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWCKLw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 06:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWCKLw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 06:52:56 -0500
Received: from pproxy.gmail.com ([64.233.166.177]:27548 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751094AbWCKLwz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 06:52:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K2ui3cf84iDRoT1oZediYx9I9R7B4sgB43Ezebb0HuTdHR75YWVkvWi1FnEceM2JfGf8wxJJ9otwmPOxBmjSks+LBS3aCWES8z+y1RCpBpvX9RDeirUFeWz5CZuiWeJu+eyyuCahWZQapa+O0rg005GKOIsTUN3xIN+DeLQajkk=
Message-ID: <aec7e5c30603110352u4a18825ai1aaa6c5eac04685d@mail.gmail.com>
Date: Sat, 11 Mar 2006 20:52:53 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [PATCH 00/03] Unmapped: Separate unmapped and mapped pages
Cc: "Magnus Damm" <magnus@valinux.co.jp>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <1141999506.2876.45.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060310034412.8340.90939.sendpatchset@cherry.local>
	 <1141977139.2876.15.camel@laptopd505.fenrus.org>
	 <aec7e5c30603100519l5a68aec3ub838ac69a734a46b@mail.gmail.com>
	 <1141999506.2876.45.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Fri, 2006-03-10 at 14:19 +0100, Magnus Damm wrote:
> > My current code just extends this idea which basically means that
> > there is currently no relation between how many pages that sit in each
> > LRU. The LRU with the largest amount of pages will be shrunk/rotated
> > first. And on top of that is the guarantee logic and the
> > reclaim_mapped threshold, ie the unmapped LRU will be shrunk first by
> > default.
>
> that sounds wrong, you lose history this way. There is NO reason to
> shrink only the unmapped LRU and not the mapped one. At minimum you
> always need to pressure both. How you pressure (absolute versus
> percentage) is an interesting question, but to me there is no doubt that
> you always need to pressure both, and "equally" to some measure of equal

Regarding if shrinking the unmapped LRU only is bad or not: In the
vanilla version of refill_inactive_zone(), if reclaim_mapped is false
then mapped pages are rotated on the active list without the
young-bits are getting cleared in the PTE:s. I would say this is very
similar to leaving the pages on the mapped active list alone as long
as reclaim_mapped is false in the dual LRU case. Do you agree?

Also, losing history, do you mean that the order of the pages are not
kept? If so, then I think my refill_inactive_zone() rant above shows
that the order of the pages are not kept today. But yes, keeping the
order is probaly a good idea.

It would be interesting to hear what you mean by "pressure", do you
mean that both the active list and inactive list are scanned?

Many thanks,

/ magnus

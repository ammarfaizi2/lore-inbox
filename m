Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbVKHQIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbVKHQIU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbVKHQIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:08:20 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:55424 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030235AbVKHQIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:08:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=1sQo9913cHUXblV0gGB3OeyAc178Gsd7W4IftkSzZvA8kKMN9vOcMc3MOO7ye8kUukKC10oOq1tLK9/ub9V7yOJWPwsHJRJLrwaEs95VfRq8G+3syImN8wKU16jwu7RZ2G8iYemxnnYjO0+ALMzROJamVizKBu6YJEa0Q4rE5gM=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 8/10] UML - Maintain own LDT entries
Date: Tue, 8 Nov 2005 17:02:02 +0100
User-Agent: KMail/1.8.3
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       Allan Graves <allan.graves@oracle.com>
References: <200510310439.j9V4dfbw000872@ccure.user-mode-linux.org> <200511072028.23111.blaisorblade@yahoo.it> <4370C36E.2040205@fujitsu-siemens.com>
In-Reply-To: <4370C36E.2040205@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511081702.02891.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 November 2005 16:25, Bodo Stroesser wrote:
> Blaisorblade wrote:
> > On Monday 07 November 2005 13:20, Bodo Stroesser wrote:
> >>Blaisorblade wrote:
> >>>On Monday 31 October 2005 05:39, Jeff Dike wrote:
> >>>>From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

> In my opinion there is no reason to change the current implementation for
> SAKS3/0. Note: if someone reads LDT via [sys_]modify_ldt(), he will receive
> the requested data in "processor format", that is LDT-descriptors. He will
> receive a list of descriptors starting at the first descriptor of the LDT,
> thus no entry number is needed in the enties.
Ehrr... ACK! You're right, I really _did_ miss the read_ldt case.
> The only case that uses user_desc is when writing one desriptor via
> modify_ldt(). modify_ldt(WRITE) exactly writes one LDT-descriptor, so
> user_desc must contain the number of the entry to write. Thus user_desc is
> bigger than LDT descriptor. It also uses an other data layout resulting in
> double the size of LDT-descriptor. So I think it doesn't make sense to
> store user_desc. We save memory storing the resulting LDT-descriptors,
> which then are copied transparently on modify_ldt(READ). Conversion between
> user_desc and LDT-entry is done on modify_ldt(WRITE) in SKAS0 only. No
> other conversions are done in UML.

Ok, I now totally agree with your point. I had missed the read_ldt case. It's 
perfectly fine to keep it as-is.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it

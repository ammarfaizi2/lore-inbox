Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWDZQgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWDZQgE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 12:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWDZQgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 12:36:04 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:65387 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932211AbWDZQgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 12:36:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=E2v+PpULkHiHVIgMarhJxSAJ8hitxxKv5CpdBgY0Tt8S8eco7UItObESOQyqDeTc9wUOvQ2BHm5JFDMb0F4pfwkJiwFtLFxz2bYJU7nPP/jlUt10X1GplO70cXcGuH7k88I3guhC7Mr1z0sL9ZKI8pubGgIN/PM230RSZpwabxI=  ;
Message-ID: <444F4673.7060702@yahoo.com.au>
Date: Wed, 26 Apr 2006 20:07:47 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Daniel Walker <dwalker@mvista.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, hzhong@gmail.com
Subject: Re: [PATCH] Profile likely/unlikely macros
References: <200604250257.k3P2vlEb012502@dwalker1.mvista.com> <20060424200657.0af43d6a.akpm@osdl.org> <444DF5B4.6030004@yahoo.com.au> <1145989423.3674.17.camel@localhost.localdomain> <444EC7F9.8080208@yahoo.com.au> <20060426095602.GB29108@wohnheim.fh-wedel.de>
In-Reply-To: <20060426095602.GB29108@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:

> Admitted, I'm a bit slow at times.  But why does this matter?
> According to my fairly limited brain, you take a potentially expensive
> barrier, so you pay with a bit of runtime.  What you buy is a smaller
> critical section, so you can save some runtime on other cpus.  When
> optimizing for the common case, which is one cpu, this is a net loss.
> 
> There must be some correctness issue hidden that I cannot see.  Can
> you explain that to me?

Another CPU may find the bit clear, enter the critical section,
and load the old `likeliness_head' (value before being changed
by this CPU).

Then it stores the old value to likeliness->next, and overwrites
likeliness_head.

One CPU's update has now gotten lost.

(there are probably other examples, like missing likliness->type)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

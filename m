Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVFQNJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVFQNJX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 09:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVFQNJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 09:09:23 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:64981 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261955AbVFQNJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 09:09:15 -0400
Date: Fri, 17 Jun 2005 09:09:14 -0400
To: Patrick McFarland <pmcfarland@downeast.net>
Cc: M?ns Rullg?rd <mru@inprovide.com>,
       "Richard B. Johnson" <linux-os@analogic.com>,
       Lukasz Stelmach <stlman@poczta.fm>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Message-ID: <20050617130914.GB23488@csclub.uwaterloo.ca>
References: <yw1xslzl8g1q.fsf@ford.inprovide.com> <200506162118.18470.pmcfarland@downeast.net> <yw1xekb1xuk9.fsf@ford.inprovide.com> <200506170450.12943.pmcfarland@downeast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506170450.12943.pmcfarland@downeast.net>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 04:49:33AM -0400, Patrick McFarland wrote:
> (implication of utf8 and not utf16 goes here)
> 
> Very few Unicode characters require three bytes, instead of the usual one or 
> two.
> 
> For one byte you just have the byte. 
> 
> For two bytes, you really have three: a control code stating "the following 
> two bytes are a two byte character", and then the two bytes. 
> 
> For three bytes, you really have four bytes: a control code stating "the 
> following three bytes are a three byte character" and then the three bytes.
> 
> Unless I've completely misunderstood the Unicode specification, this is what 
> is going on.

You have probably slightly misunderstood UTF8 at least.  UTF8 tries very
hard to make sure you can't mistake the characters for ascii, so it
makes the first byte contains some 1's follwed by one zero.  The number
of 1's indicates how many bytes the character contains, after the 0 the
remaining bits is used to store bits for the character.  The remaining
bytes are all 10xxxxxx which stores another 6 bites of the character code.
One is required to use the shortest form of utf8 that can store the
character you are encoding.

x's are where the bits for the character number go:
0xxxxxxx encodes character 0-127
110xxxxx 10xxxxxx encodes character 128-2047
1110xxxx 10xxxxxx 10xxxxxx encodes characters 2048-65535
etc up to
1111110x 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx encodes characters
67108864-2147483647

As far as I know, unicode doesn't currently define anything past 20bits
or so, so probably 4bytes is the most you will see in normal use, with 3
bytes covering quite a large number of the characters.

> Any English characters (ie, the first 127 ascii characters) map directly to 
> the first 127 Unicode characters (if thats what you meant).

Well utf8 also is backwards compatible with ascii to make handling text
files simpler.  You could encode the ascii characters using the other
part of UTF8 except that would violate the rule of using the shortest
form possible.

Len Sorensen

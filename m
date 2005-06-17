Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVFQJRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVFQJRs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 05:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVFQJRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 05:17:48 -0400
Received: from 76.80-203-227.nextgentel.com ([80.203.227.76]:11997 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S261926AbVFQJRl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 05:17:41 -0400
To: Patrick McFarland <pmcfarland@downeast.net>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       "Richard B. Johnson" <linux-os@analogic.com>,
       Lukasz Stelmach <stlman@poczta.fm>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
References: <yw1xslzl8g1q.fsf@ford.inprovide.com>
	<200506162118.18470.pmcfarland@downeast.net>
	<yw1xekb1xuk9.fsf@ford.inprovide.com>
	<200506170450.12943.pmcfarland@downeast.net>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Fri, 17 Jun 2005 11:17:39 +0200
In-Reply-To: <200506170450.12943.pmcfarland@downeast.net> (Patrick
 McFarland's message of "Fri, 17 Jun 2005 04:49:33 -0400")
Message-ID: <yw1xy899wde4.fsf@ford.inprovide.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McFarland <pmcfarland@downeast.net> writes:

> On Friday 17 June 2005 04:21 am, Måns Rullgård wrote:
>> Patrick McFarland <pmcfarland@downeast.net> writes:
>> > On Thursday 16 June 2005 11:04 am, Lennart Sorensen wrote:
>> >>  Most people seem happy with 50 or so being a good limit even though
>> >> many systems support much longer.
>> >
>> > 50 characters or 50 bytes? Because in the case of UTF-8, if you do a lot
>> > of three byte characters (which require four bites to encode), 50 bytes
>> > is very short.
>>
>> What do you mean by three-byte characters requiring four bytes to
>> encode?  Is a three-byte character not a character encoded using three
>> bytes?
>
> (implication of utf8 and not utf16 goes here)
>
> Very few Unicode characters require three bytes, instead of the
> usual one or two.

I wouldn't the Chinese, Japanese, and Korean characters "very few",
and those all require (at least) three bytes.

> For one byte you just have the byte. 

Correct.

> For two bytes, you really have three: a control code stating "the
> following two bytes are a two byte character", and then the two
> bytes.
>
> For three bytes, you really have four bytes: a control code stating
> "the following three bytes are a three byte character" and then the
> three bytes.

Wrong.  The first byte indicates the total size of the character, but
it also contains data, like this:

  0xxxxxxx
  110xxxxx 10xxxxxx
  1110xxxx 10xxxxxx 10xxxxxx
  11110xxx 10xxxxxx 10xxxxxx 10xxxxxx

Refer to the Unicode standard, section 3.9 for the full details.

>> As for 50 bytes being too short, many of the multibyte characters are
>> equivalent to several English characters, so fewer of them are
>> required.  You have a point, though.
>
> Any English characters (ie, the first 127 ascii characters) map
> directly to the first 127 Unicode characters (if thats what you
> meant).

Let me clarify with an example.  The common Korean name Kim consists
of three ascii characters.  The Hangul spelling, ~, is encoded in
utf-8 using three bytes.  Even though a three-byte character was used,
the number of bytes is the same.

-- 
Måns Rullgård
mru@inprovide.com

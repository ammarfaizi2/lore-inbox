Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751881AbWCRFpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbWCRFpF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 00:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbWCRFpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 00:45:04 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:31313 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751881AbWCRFpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 00:45:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=M77EnEjdJgOBXFCxLv9+coK5kMxHL7+mHJgKWZPSq4PU5C8AOLlt06Jy2/XXMNUixxGnC2OA0ujjuRCYUWJffZ+b42hmrcyIY3f4Uq0yNx0b8yzk4AWyKFELJaoHqClFbyxcAC7ITNN6854KQRDOnIVxjLa6L2/f8oYAOF38hX8=  ;
Message-ID: <441B9E5A.1040703@yahoo.com.au>
Date: Sat, 18 Mar 2006 16:44:58 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, ck@vds.kolivas.org,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
       Stefan Seyfried <seife@suse.de>
Subject: Re: [PATCH][RFC] mm: swsusp shrink_all_memory tweaks
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <200603181546.20794.kernel@kolivas.org> <441B9205.5010701@yahoo.com.au> <200603181556.23307.kernel@kolivas.org>
In-Reply-To: <200603181556.23307.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Saturday 18 March 2006 15:52, Nick Piggin wrote:
> 
>>Con Kolivas wrote:
>>
>>>
>>>#ifdeffery
>>
>>Sorry I don't understand...
> 
> 
> My bad.
> 
> I added the suspend_pass member to struct scan_control within an #ifdef 
> CONFIG_PM to allow it to not be unnecessarily compiled in in the !CONFIG_PM 
> case and wanted to avoid having the #ifdefs in vmscan.c so moved it to a 
> header file.
> 

Oh no, that rule thumb isn't actually "don't put ifdefs in .c files", but
people commonly say it that way anyway. The rule is actually that you should
put ifdefs in declarations rather than call/usage sites.

You did the right thing there by introducing the accessor, which moves the
ifdef out of code that wants to query the member right? But you can still
leave it in the .c file if it is local (which it is).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

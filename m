Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264345AbUDTX5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264345AbUDTX5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 19:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUDTX5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 19:57:54 -0400
Received: from chococat.sd.dreamhost.com ([66.33.206.16]:63436 "EHLO
	chococat.sd.dreamhost.com") by vger.kernel.org with ESMTP
	id S264189AbUDTX5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 19:57:50 -0400
Message-ID: <12913.24.6.86.122.1082505469.spork@webmail.coverity.com>
In-Reply-To: <20040420232545.GF17014@parcelfarce.linux.theplanet.co.uk>
References: <12837.24.6.86.122.1082499261.spork@webmail.coverity.com>
    <20040420232545.GF17014@parcelfarce.linux.theplanet.co.uk>
Date: Tue, 20 Apr 2004 16:57:49 -0700 (PDT)
Subject: Re: [CHECKER] Security reports involving isspace()
From: ken@coverity.com
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org, linux@coverity.com
User-Agent: DreamHost Webmail
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Apr 20, 2004 at 03:14:21PM -0700, ken@coverity.com wrote:
>> All of the reports below deal with the isspace macro.  It expands to an
>> access to a static array with 256 entries.  If we use an unsigned char
>> to
>> index into the array, there are no problems.  However, when that char is
>> signed, we can index off the left of the array.
>>
>> It seems like this isn't a big deal, but if the isspace array is located
>> after some important data structure, we could leak information.
>
> #define __ismask(x) (_ctype[(int)(unsigned char)(x)])
> #define isspace(c)      ((__ismask(c)&(_S)) != 0)

Sorry, my mistake.  I only saw the cast to int in __ismask(x).  Thanks for
the quicky reply.

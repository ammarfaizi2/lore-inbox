Return-Path: <linux-kernel-owner+w=401wt.eu-S932303AbXADHLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbXADHLp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 02:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbXADHLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 02:11:45 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:13268 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932303AbXADHLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 02:11:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=i1pQXVKbcvjXO0P3p4MnNPpFpMoJNN/w45l2+W8SbxPs/UFeUkx5YYIoPVmIhKi+J/BEdU7HuAEJrQ8cY89nIVyxDmDDNaUkCeYI1w62SZBM5YaT+y2aVvuSCHBPIDPAKNep9RUYesRoUa50OEYlGDZkBEmK3DSssL7QAyOQpjA=
Message-ID: <787b0d920701032311l2c37c248s3a97daf111fe88f3@mail.gmail.com>
Date: Thu, 4 Jan 2007 02:11:42 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: mikpe@it.uu.se, s0348365@sms.ed.ac.uk, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, bunk@stusta.de
Subject: Re: kernel + gcc 4.1 = several problems
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> [probably Mikael Pettersson] writes:

>> The suggestions I've had so far which I have not yet tried:
>>
>> - Select a different x86 CPU in the config.
>>   - Unfortunately the C3-2 flags seem to simply tell GCC to
>>     schedule for ppro (like i686) and enabled MMX and SSE
>>   - Probably useless
>
> Actually, try this one. Try using something that doesn't like "cmov".
> Maybe the C3-2 simply has some internal cmov bugginess.

Of course that changes register usage, register spilling,
and thus ultimately even the stack layout. :-(

Adjusting gcc flags to eliminate optimizations is another way to go.
Adding -fwrapv would be an excellent start. Lack of this flag breaks
most code which checks for integer wrap-around. The compiler "knows"
that signed integers don't ever wrap, and thus eliminates any code
which checks for values going negative after a wrap-around. I could
imagine this affecting a switch() or other jump table.

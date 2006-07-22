Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWGVIFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWGVIFX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 04:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWGVIFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 04:05:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:9499 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751269AbWGVIFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 04:05:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=A2aXqzJOiZsR1wpAEYkXxTIHDCpVXhIZumkw2A5kE7AW4y+iTU83MD11etw6xs6/bpZtsvjLBuDdY2dVJBoqrcfJesznxwgdCO+Tj3aV82HL/cOl17WtapGZf10ReUw5AJkoWmxoFtl7eqUuKUw2CwflxhqAf0jHhP3Lc6yFgXg=
Message-ID: <787b0d920607220105l21251402nc98381edbc27a0c5@mail.gmail.com>
Date: Sat, 22 Jul 2006 04:05:19 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: froese@gmx.de, B.Steinbrink@gmx.de, hurtta+gmane@siilo.fmi.fi,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC/PATCH] revoke/frevoke system calls
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edgar Toernig writes:
> Bjvrn Steinbrink wrote:

>> In do_revoke() there is:
>>
>> +    if (current->fsuid != inode->i_uid && !capable(CAP_FOWNER)) {
>> +            ret = -EPERM;
>> +            goto out;
>>
>> That pretty much matches what the BSD manpage says.
>
> Urgs, so any user may remove mappings from another process and
> let it crash?

Two good solutions come to mind:

a. substitute the zero page
b. make the mapping private and touch it as if C-O-W happened

Other concerns:

Optionally excluding the current UID/TGID/TID would be good.
(some flags) A revokeat() call seems to be required. Be sure
to handle working directories. The controlling tty is special.
Flag processes with revoked ttys in /proc/*/stat please, so
that ps can report it properly without opening another file.

BTW, it is wonderful to see this happening.

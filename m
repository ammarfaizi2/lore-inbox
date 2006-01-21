Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWAUWfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWAUWfs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 17:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWAUWfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 17:35:48 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:28366 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751210AbWAUWfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 17:35:47 -0500
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.15: Filesystem capabilities 0.16
References: <200601161916.k0GJGm7T002751@laptop11.inf.utfsm.cl>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sat, 21 Jan 2006 23:35:35 +0100
Message-ID: <87psml43bc.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late response, I've been away for the week.

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

> Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de> wrote:
>> +	  For example, you may drop the SUID bit from ping and grant the
>> +	  CAP_NET_RAW capability:
>> +	  # chmod u-s /bin/ping
>> +	  # chcap cap_net_raw=ep /bin/ping
>
> Why the cap_ part? It should be enough to say, e.g.
>
>     chcap net-raw=ep /bin/ping
>
> ('_' has SHIFT, normally... '-' is easier to type)

This is the way libcap expects the capabilities string. I never
questioned the format of this string. But it isn't hard to do a simple
mapping.

>> +
>> +	  Another use would be to run system daemons with their own uid:
>> +	  # chcap cap_net_bind_service=ei /usr/sbin/named
>> +	  This sets the effective and inheritable capabilities of named.
>> +
>> +	  In your startup script:
>> +	  inhcaps cap_net_bind_service=i bind:bind /usr/sbin/named
>
> AFAIU, the =i implies inherited, why another command to set that?

Look for keep_capabilities in security/commoncap.c. If you do a
setuid() away from root, Linux drops all privileges. Inhcaps does a
setuid() and arranges for keeping the needed capabilities.

Regards, Olaf.

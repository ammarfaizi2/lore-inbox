Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWAYUlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWAYUlf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 15:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWAYUlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 15:41:35 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:54461 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1750828AbWAYUlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 15:41:35 -0500
Date: Wed, 25 Jan 2006 21:40:38 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/04] Add encryption ops to the keyctl syscall
Message-ID: <20060125204038.GC12039@hardeman.nu>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	linux-kernel@vger.kernel.org
References: <1138048952965@2gen.com> <17515.1138100304@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <17515.1138100304@hades.cambridge.redhat.com>
User-Agent: Mutt/1.5.11
X-SA-Score: -2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 10:58:24AM +0000, David Howells wrote:
>> +	key = key_ref_to_ptr(key_ref);
>> +
>> +	/* see if we can read it directly */
>> +	ret = key_permission(key_ref, KEY_READ);
>
>You don't actually need to calculate key until after you've done all those
>checks, so I'd move it further down the file. You can use the function to
>release key references in the error handling or have a separate error handling
>return path.

Do you mean that I should move the key_ref_to_ptr call to right after 
the can_read_key label? If that is the case, shouldn't the same thing be 
done for keyctl_read_key?

>> +			down_read(&key->sem);
>> +			ret = key->type->encrypt(key, data, dlen, result, rlen);
>> +			up_read(&key->sem);
>
>Do we really want to restrict the key type implementor to using the r/w
>semaphore. Would it be better to let the type decide whether it wants to use
>the semaphore or let it use RCU if it so desires?

Ok, I'll move the semaphore into the dsa key type instead and change the 
appropriate comments.

Re,
David

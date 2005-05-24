Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVEXSFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVEXSFi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 14:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVEXSFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 14:05:38 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:10730 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261185AbVEXSFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 14:05:23 -0400
Message-ID: <42936CA4.1020905@google.com>
Date: Tue, 24 May 2005 11:04:20 -0700
From: Mike Waychison <mikew@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
CC: jamie@shareable.org, linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC][PATCH] rbind across namespaces
References: <1116627099.4397.43.camel@localhost> <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu> <1116660380.4397.66.camel@localhost> <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu> <20050521134615.GB4274@mail.shareable.org> <E1DZlVn-0007a6-00@dorka.pomaz.szeredi.hu> <429277CA.9050300@google.com> <E1DaSCb-0003Tw-00@dorka.pomaz.szeredi.hu> <4292D416.5070001@waychison.com> <E1DaUj1-0003eq-00@dorka.pomaz.szeredi.hu> <42935FCB.1010809@google.com> <E1DadFv-0004Te-00@dorka.pomaz.szeredi.hu> <42936807.2000807@google.com> <E1DaddR-0004Ws-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1DaddR-0004Ws-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
>>So you'd say 'mount /dev/foo /proc/self/fd/4' if 4 was an fd pointing to 
>>a directory in another namespace?
>>
>>That does require proc_check_root be removed.  :\
> 
> 
> Or just make an exception to self?
> 
> proc_check_root() could begin with:
> 
> 	if (current == proc_task(inode))
> 		return 0;
> 
> For all other tasks it would still be effective.
> 

Yes, I think something like that is workable :)

(we still have to fix up all the namespace->sem locking.  I have yet to 
review Ram's patch.)

Mike Waychison

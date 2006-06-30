Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbWF3MXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWF3MXU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 08:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWF3MXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 08:23:20 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:19625 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S932504AbWF3MXS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 08:23:18 -0400
Message-ID: <44A517B4.4010500@fr.ibm.com>
Date: Fri, 30 Jun 2006 14:23:16 +0200
From: Daniel Lezcano <dlezcano@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: Cedric Le Goater <clg@fr.ibm.com>, Sam Vilain <sam@vilain.net>,
       hadi@cyberus.ca, Herbert Poetzl <herbert@13thfloor.at>,
       Alexey Kuznetsov <alexey@sw.ru>, viro@ftp.linux.org.uk,
       devel@openvz.org, dev@sw.ru, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrey Savochkin <saw@swsoft.com>, Ben Greear <greearb@candelatech.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: strict isolation of net interfaces
References: <m1psgulf4u.fsf@ebiederm.dsl.xmission.com> <44A1689B.7060809@candelatech.com> <20060627225213.GB2612@MAIL.13thfloor.at> <1151449973.24103.51.camel@localhost.localdomain> <20060627234210.GA1598@ms2.inr.ac.ru> <m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com> <20060628133640.GB5088@MAIL.13thfloor.at> <1151502803.5203.101.camel@jzny2> <44A44124.5010602@vilain.net> <44A450D1.2030405@fr.ibm.com> <20060630023947.GA24726@sergelap.austin.ibm.com>
In-Reply-To: <20060630023947.GA24726@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn wrote:
> Quoting Cedric Le Goater (clg@fr.ibm.com):
> 
>>we could work on virtualizing the net interfaces in the host, map them to
>>eth0 or something in the guest and let the guest handle upper network layers ?
>>
>>lo0 would just be exposed relying on skbuff tagging to discriminate traffic
>>between guests.
> 
> 
> This seems to me the preferable way.  We create a full virtual net
> device for each new container, and fully virtualize the device
> namespace.

I have a few questions about all the network isolation stuff:

   * What level of isolation is wanted for the network ? network devices 
? IPv4/IPv6 ? TCP/UDP ?

   * How is handled the incoming packets from the network ? I mean what 
will be mecanism to dispatch the packet to the right virtual device ?

   * How to handle the SO_BINDTODEVICE socket option ?

   * Has the virtual device a different MAC address ? How to manage it 
with the real MAC address on the system ? How to manage ARP, ICMP, 
multicasting and IP ?

It seems for me, IMHO that will require a lot of translation and 
browsing table. It will probably add a very significant overhead.

    * How to handle NFS access mounted outside of the container ?

    * How to handle ICMP_REDIRECT ?

Regards








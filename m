Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbUBTSxs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 13:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbUBTSxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 13:53:48 -0500
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:21777 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S261237AbUBTSxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 13:53:42 -0500
Message-ID: <403658D5.1030206@kolumbus.fi>
Date: Fri, 20 Feb 2004 20:58:29 +0200
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
CC: Andreas Schwab <schwab@suse.de>, greg@kroah.com,
       linux-kernel@vger.kernel.org, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH]2.6.3-rc2 MSI Support for IA64
References: <C7AB9DA4D0B1F344BF2489FA165E5024040580FB@orsmsx404.jf.intel.com>
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024040580FB@orsmsx404.jf.intel.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 20.02.2004 20:55:58,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 20.02.2004 20:55:04,
	Serialize complete at 20.02.2004 20:55:04
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ia64 already has a function ia64_alloc_vector(void) in 
arch/ia64/kernel/irq_ia64, why the doubling?

--Mika


Nguyen, Tom L wrote:

>Friday, Feb. 20, 2004 8:55 AM, Andreas Schwab wrote:
>
>  
>
>>>@@ -316,6 +310,19 @@
>>> 	return current_vector;
>>> }
>>> 
>>>+int ia64_alloc_vector(void)
>>>+{
>>>+	static int next_vector = IA64_FIRST_DEVICE_VECTOR;
>>>+
>>>+	if (next_vector > IA64_LAST_DEVICE_VECTOR)
>>>+		/* XXX could look for sharable vectors instead of panic'ing... */
>>>+		panic("ia64_alloc_vector: out of interrupt vectors!");
>>>+
>>>+	nr_alloc_vectors++;
>>>+
>>>+	return next_vector++;
>>>+}
>>>+
>>>      
>>>
>
>  
>
>>IMHO this should be CONFIG_IA64 only.
>>    
>>
>
>To avoid some #ifdef statements as possible, "ia64_platform" 
>defined in the header file "msi.h" is set to TRUE only if 
>setting CONFIG_IA64 to 'Y'. The setting of ia64_platform
>to TRUE will execute function ia64_alloc_vector.
>
>This API is only used in assign_msi_vector()in msi.c:
>
>	vector = (ia64_platform ? ia64_alloc_vector() :
>		assign_irq_vector(MSI_AUTO));
>
>Thanks,
>Long
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


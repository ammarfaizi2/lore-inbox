Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754705AbWKIIbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705AbWKIIbk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 03:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754711AbWKIIbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 03:31:40 -0500
Received: from 147.175.241.83.in-addr.dgcsystems.net ([83.241.175.147]:25536
	"EHLO tmnt04.transmode.se") by vger.kernel.org with ESMTP
	id S1754705AbWKIIbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 03:31:39 -0500
Message-ID: <4552E769.2030303@transmode.se>
Date: Thu, 09 Nov 2006 09:31:37 +0100
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
User-Agent: Thunderbird 1.5.0.7 (X11/20061017)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>,
       Joakim Tjernlund <joakim.tjernlund@transmode.se>,
       linux-kernel@vger.kernel.org
Subject: Re: How to compile module params into kernel?
References: <9a8748490611081105j5ca1d24ahd49c6d9ea7d980d3@mail.gmail.com> <02fd01c70370$d9af6700$020120ac@Jocke> <9a8748490611081209s37e5bfa7m2ddb49a23288ffbd@mail.gmail.com> <20061108201456.GD21485@lug-owl.de>
In-Reply-To: <20061108201456.GD21485@lug-owl.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Nov 2006 08:31:37.0480 (UTC) FILETIME=[78EAF880:01C703D9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw wrote:
> On Wed, 2006-11-08 21:09:04 +0100, Jesper Juhl <jesper.juhl@gmail.com> wrote:
>   
>> On 08/11/06, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
>>     
>>>> -----Original Message-----
>>>> From: Jesper Juhl [mailto:jesper.juhl@gmail.com]
>>>> On 08/11/06, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
>>>>         
>>>>> Instead of passing a module param on the cmdline I want to compile that
>>>>> into the kernel, but I can't figure out how.
>>>>>           
>>>> You could edit the module source and hardcode default values.
>>>>         
>>> Yes, but I don't want to do that since it makes maintance
>>> harder.
>>>       
>> Well, as far as I know, there's no way to specify default module
>> options at compile time. The defaults are set in the module source and
>> are modifiable at module load time or by setting options on the kernel
>> command line at boot tiem. So, if that's no good for you I don't see
>> any other way except modifying the source to hardcode new defaults.
>>     
>
> However, that could probably be hacked in easily. We use a similar
> approach for VAX, since we're not yet regularly booting off a local
> harddisk, but commonly via MOP off the network.
>
> MfG, JBG
>
>   
This works for me in should want to known:

#include <linux/moduleparam.h>
int set_module_params(void)
{
   extern struct kernel_param __start___param[], __stop___param[];
   char module_params[]="rtc-ds1307.force=0,0x68";

   parse_args("hard module params", module_params, __start___param,
          __stop___param - __start___param, NULL);
   return 0;
}
arch_initcall(set_module_params);


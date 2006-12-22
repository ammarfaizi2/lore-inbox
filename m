Return-Path: <linux-kernel-owner+w=401wt.eu-S1945973AbWLVIWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945973AbWLVIWz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 03:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945978AbWLVIWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 03:22:55 -0500
Received: from smtp1.telegraaf.nl ([217.196.45.193]:39416 "EHLO
	smtp1.telegraaf.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945973AbWLVIWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 03:22:54 -0500
Date: Fri, 22 Dec 2006 09:22:48 +0100
From: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, take@libero.it, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Message-ID: <20061222082248.GY31882@telegraafnet.nl>
References: <117E3EB5059E4E48ADFF2822933287A401F2EB70@pdsmsx404.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <117E3EB5059E4E48ADFF2822933287A401F2EB70@pdsmsx404.ccr.corp.intel.com>
User-Agent: Mutt/1.5.9i
X-telegraaf-MailScanner-From: ard@telegraafnet.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
On Fri, Dec 22, 2006 at 12:41:46PM +0800, Zhang, Yanmin wrote:
> I think parse_args enables irq when it calls callbacks.
> Could you try below?
> 1) Test Andrew's patch of sema down_write;
> 2) Apply below patch and see what the output is when booting. If the output has
> "[BUG]..address.", Pls. map the address to function name by System.map.
Without proof^H^H^H^H^Hpasting my dmesg and the "diff", I already
concluded that ide_setup was the culprit. (I've debuged
parse_one, and it barfed around the 3rd parameter which is
hdb=noprobe).
Anyway, a bad night of sleep reminds me that our EM64T boxes also
have this line (which actually is a remainder of our VA1220 boxes
;-) ), and they don't barf, so it must be either the combination
of the sata_nv together with the pata driver part, *or* just the
pata driver part. (Our opteron != nforce chipsets also works).

I will trace down the ide_setup today. First loads of coffee.

-- 
program signature;
begin  { telegraaf.com
} writeln("<ard@telegraafnet.nl> TEM2");
end
.

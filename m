Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261542AbSJ1Wax>; Mon, 28 Oct 2002 17:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261630AbSJ1Wax>; Mon, 28 Oct 2002 17:30:53 -0500
Received: from momus.sc.intel.com ([143.183.152.8]:32199 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S261542AbSJ1Wav>; Mon, 28 Oct 2002 17:30:51 -0500
Message-ID: <F2DBA543B89AD51184B600508B68D4000ECE76E2@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hyper-threading information in /proc/cpuinfo
Date: Mon, 28 Oct 2002 14:36:31 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like they don't want us to use "threads" for various reasons. Those
could be even religious/branding issues, which I have no interests in. My
interest is to have consistent format/info for HT cpuinfo among the kernels.

So can you please change like:

+#ifdef CONFIG_SMP
+	if (cpu_has_ht) {
+		seq_printf(m, "physical id\t: %d\n", phys_proc_id[n]);
+		seq_printf(m, "logical cpus\t: %d per package\n",
smp_num_siblings);
+	}
+#endif

This is consistent with the spec/manual from Intel. They use logical
processor (and thread :-), physical processor, physical package, etc.

Thanks,
Jun

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Friday, October 25, 2002 3:15 PM
To: Nakajima, Jun
Cc: Robert Love; 'Dave Jones'; 'akpm@digeo.com';
'linux-kernel@vger.kernel.org'; 'chrisl@vmware.com'; 'Martin J. Bligh'
Subject: RE: [PATCH] hyper-threading information in /proc/cpuinfo


On Fri, 2002-10-25 at 22:50, Nakajima, Jun wrote:
> Sorry,
> 
> Can you please change "siblings\t" to "threads\t\t". SuSE 8.1, for
example,
> is already doing it:

Could do
> 
> +#ifdef CONFIG_SMP
> +	if (cpu_has_ht) {
> +		seq_printf(m, "physical id\t: %d\n", phys_proc_id[n]);
> +		seq_printf(m, "threads\t\t: %d\n", smp_num_siblings);
> +	}
> +#endif


Im just wondering what we would then use to describe a true multiple cpu
on a die x86. Im curious what the powerpc people think since they have
this kind of stuff - is there a generic terminology they prefer ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

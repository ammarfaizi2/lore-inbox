Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278911AbRJVUya>; Mon, 22 Oct 2001 16:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278913AbRJVUyV>; Mon, 22 Oct 2001 16:54:21 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:52740 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S278911AbRJVUyH>; Mon, 22 Oct 2001 16:54:07 -0400
Message-ID: <001501c15b3b$f1052990$6401000a@it0>
From: "Tommy Faasen" <faasen@xs4all.nl>
To: <linux-kernel@vger.kernel.org>
Subject: SMP: why can't I get this to work?
Date: Mon, 22 Oct 2001 22:55:54 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to check all the cpu's for a certain capability I came up with
the following, but you guessed it, it won't work :(

I added this to bitops.h
static int test_bits(int nr, const volatile void * addr,int step,int ncpu){
 int i;
 for(i=0;i<ncpu;i++)
 {
  if(test_bit(nr,&addr+(i*step))==0)return(0);
 }
 return(1);
}

And this to processor.h

#ifdef CONFIG_SMP
extern struct cpuinfo_x86 cpu_data[];
#define current_cpu_data cpu_data[smp_processor_id()]

#define cpu_has_pge (test_bits(X86_FEATURE_PGE,
current_cpu_data.x86_capability,sizeof(struct cpuinfo_x86),NR_CPUS))
#define cpu_has_pse (test_bits(X86_FEATURE_PSE,
current_cpu_data.x86_capability,sizeof(struct cpuinfo_x86),NR_CPUS))
#define cpu_has_pae (test_bits(X86_FEATURE_PAE,
current_cpu_data.x86_capability,sizeof(struct cpuinfo_x86),NR_CPUS))
#define cpu_has_tsc (test_bits(X86_FEATURE_TSC,
current_cpu_data.x86_capability,sizeof(struct cpuinfo_x86),NR_CPUS))
#define cpu_has_de (test_bits(X86_FEATURE_DE,
current_cpu_data.x86_capability,sizeof(struct cpuinfo_x86),NR_CPUS))
#define cpu_has_vme (test_bits(X86_FEATURE_VME,
current_cpu_data.x86_capability,sizeof(struct cpuinfo_x86),NR_CPUS))
#define cpu_has_fxsr (test_bits(X86_FEATURE_FXSR,
current_cpu_data.x86_capability,sizeof(struct cpuinfo_x86),NR_CPUS))
#define cpu_has_xmm (test_bits(X86_FEATURE_XMM,
current_cpu_data.x86_capability,sizeof(struct cpuinfo_x86),NR_CPUS))
#define cpu_has_fpu (test_bits(X86_FEATURE_FPU,
current_cpu_data.x86_capability,sizeof(struct cpuinfo_x86),NR_CPUS))
#define cpu_has_apic (test_bits(X86_FEATURE_APIC,
current_cpu_data.x86_capability,sizeof(struct cpuinfo_x86),NR_CPUS))
#else
#define cpu_data &boot_cpu_data
#define current_cpu_data boot_cpu_data

#define cpu_has_pge (test_bit(X86_FEATURE_PGE,
boot_cpu_data.x86_capability))
#define cpu_has_pse (test_bit(X86_FEATURE_PSE,
boot_cpu_data.x86_capability))
#define cpu_has_pae (test_bit(X86_FEATURE_PAE,
boot_cpu_data.x86_capability))
#define cpu_has_tsc (test_bit(X86_FEATURE_TSC,
boot_cpu_data.x86_capability))
#define cpu_has_de (test_bit(X86_FEATURE_DE,
boot_cpu_data.x86_capability))
#define cpu_has_vme (test_bit(X86_FEATURE_VME,
boot_cpu_data.x86_capability))
#define cpu_has_fxsr (test_bit(X86_FEATURE_FXSR,
boot_cpu_data.x86_capability))
#define cpu_has_xmm (test_bit(X86_FEATURE_XMM,
boot_cpu_data.x86_capability))
#define cpu_has_fpu (test_bit(X86_FEATURE_FPU,
boot_cpu_data.x86_capability))
#define cpu_has_apic (test_bit(X86_FEATURE_APIC,
boot_cpu_data.x86_capability))
#endif



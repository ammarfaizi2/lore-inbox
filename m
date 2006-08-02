Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWHBHOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWHBHOF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 03:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWHBHOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 03:14:04 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:55998
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1751300AbWHBHOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 03:14:03 -0400
Date: Wed, 2 Aug 2006 00:13:48 -0700
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rt8 crash amd64
Message-ID: <20060802071348.GA28653@gnuppy.monkey.org>
References: <20060802011809.GA26313@gnuppy.monkey.org> <1154482302.30391.14.camel@localhost.localdomain> <20060802021956.GC26364@gnuppy.monkey.org> <20060802022539.GA26799@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060802022539.GA26799@gnuppy.monkey.org>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 07:25:39PM -0700, Bill Huey wrote:
> On Tue, Aug 01, 2006 at 07:19:56PM -0700, Bill Huey wrote:
> 
> It's already compiling with frame pointers. Unfortunately, this is about
> as good it gets for a stack trace unless you've got another suggestion. 

More of the same. Looks like a lock was missed in the VM.

bill


 * INIT: Id "T4" respawning too fast: disabled for 5 minutes
  * INIT: Id "T5" respawning too fast: disabled for 5 minutes
  [ 3254.657547] BUG: scheduling while atomic: mv/0x00000001/5222
  [ 3254.663380]
  [ 3254.663381] Call Trace:
  [ 3254.667255]        <ffffffff8025ef25>{__schedule+155}
  [ 3254.672491]
  <ffffffff802616cb>{_raw_spin_unlock_irqrestore+81}
  [ 3254.679151]        <ffffffff80299218>{task_blocks_on_rt_mutex+497}
  [ 3254.685538]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3254.691121]        <ffffffff80291736>{find_task_by_pid_type+24}
  [ 3254.697243]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3254.702827]        <ffffffff8025fd49>{schedule+236}
  [ 3254.707872]        <ffffffff8026074f>{rt_lock_slowlock+351}
  [ 3254.713638]
  <ffffffff802616cb>{_raw_spin_unlock_irqrestore+81}
  [ 3254.720296]        <ffffffff8026113d>{__lock_text_start+13}
  [ 3254.726056]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3254.731640]
  <ffffffff802616a6>{_raw_spin_unlock_irqrestore+44}
  [ 3254.738297]        <ffffffff802a86ad>{__free_pages_ok+428}
  [ 3254.743972]        <ffffffff8022e29f>{__free_pages+48}
  [ 3254.749284]        <ffffffff802365bb>{free_pages+133}
  [ 3254.754508]        <ffffffff8025a8e3>{free_task+24}
  [ 3254.759553]        <ffffffff802474b7>{__put_task_struct+189}
  [ 3254.765404]        <ffffffff8025fa84>{thread_return+208}
  [ 3254.770899]
  <ffffffff802616cb>{_raw_spin_unlock_irqrestore+81}
  [ 3254.777555]        <ffffffff8025fbab>{preempt_schedule+85}
  [ 3254.783226]
  <ffffffff802616cb>{_raw_spin_unlock_irqrestore+81}
  [ 3254.789882]        <ffffffff802994b0>{rt_mutex_adjust_prio+50}
  [ 3254.795911]        <ffffffff80260bb5>{rt_lock_slowunlock+99}
  [ 3254.801762]        <ffffffff80261148>{rt_unlock+9}
  [ 3254.806715]        <ffffffff8020c585>{dput+213}
  [ 3254.811404]        <ffffffff80211809>{__fput+293}
  [ 3254.816272]        <ffffffff8022d4dd>{fput+20}
  [ 3254.820869]        <ffffffff8021adbe>{remove_vma+74}
  [ 3254.826005]        <ffffffff80210cf9>{do_munmap+631}
  [ 3254.831143]        <ffffffff80215f8d>{sys_munmap+64}
  [ 3254.836278]        <ffffffff8025df02>{ia32_sysret+0}
  [ 3254.841606] ---------------------------
  [ 3254.845554] | preempt count: 00000001 ]
  [ 3254.849503] | 1-level deep critical section nesting:
  [ 3254.854614] ----------------------------------------
  [ 3254.859725] .. [<ffffffff8025ef3d>] .... __schedule+0xb3/0xb2a
  [ 3254.865743] .....[<ffffffff8025fbab>] ..   ( <=
  preempt_schedule+0x55/0x8f)
  [ 3254.872923]
  [ 3254.882567] BUG: scheduling while atomic: mv/0x00000001/5222
  [ 3254.888406]
  [ 3254.888407] Call Trace:
  [ 3254.892279]        <ffffffff8025ef25>{__schedule+155}
  [ 3254.897508]
  <ffffffff802616cb>{_raw_spin_unlock_irqrestore+81}
  [ 3254.904168]        <ffffffff80299218>{task_blocks_on_rt_mutex+497}
  [ 3254.910556]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3254.916140]        <ffffffff80291736>{find_task_by_pid_type+24}
  [ 3254.922261]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3254.927841]        <ffffffff8025fd49>{schedule+236}
  [ 3254.932883]        <ffffffff8026074f>{rt_lock_slowlock+351}
  [ 3254.938650]
  <ffffffff802616cb>{_raw_spin_unlock_irqrestore+81}
  [ 3254.945308]        <ffffffff8026113d>{__lock_text_start+13}
  [ 3254.951068]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3254.956651]
  <ffffffff802616a6>{_raw_spin_unlock_irqrestore+44}
  [ 3254.963307]        <ffffffff802a86ad>{__free_pages_ok+428}
  [ 3254.968984]        <ffffffff8022e29f>{__free_pages+48}
  [ 3254.974298]        <ffffffff802365bb>{free_pages+133}
  [ 3254.979523]        <ffffffff8025a8e3>{free_task+24}
  [ 3254.984569]        <ffffffff802474b7>{__put_task_struct+189}
  [ 3254.990420]        <ffffffff8025fa84>{thread_return+208}
  [ 3254.995916]
  <ffffffff802616cb>{_raw_spin_unlock_irqrestore+81}
  [ 3255.002572]        <ffffffff8025fbab>{preempt_schedule+85}
  [ 3255.008244]
  <ffffffff802616cb>{_raw_spin_unlock_irqrestore+81}
  [ 3255.014899]        <ffffffff802994b0>{rt_mutex_adjust_prio+50}
  [ 3255.020929]        <ffffffff80260bb5>{rt_lock_slowunlock+99}
  [ 3255.026778]        <ffffffff80261148>{rt_unlock+9}
  [ 3255.031731]        <ffffffff8020c585>{dput+213}
  [ 3255.036420]        <ffffffff80211809>{__fput+293}
  [ 3255.041287]        <ffffffff8022d4dd>{fput+20}
  [ 3255.045882]        <ffffffff8021adbe>{remove_vma+74}
  [ 3255.051015]        <ffffffff80210cf9>{do_munmap+631}
  [ 3255.056151]        <ffffffff80215f8d>{sys_munmap+64}
  [ 3255.061285]        <ffffffff8025df02>{ia32_sysret+0}
  [ 3255.066616] ---------------------------
  [ 3255.070563] | preempt count: 00000001 ]
  [ 3255.074512] | 1-level deep critical section nesting:
  [ 3255.079623] ----------------------------------------
  [ 3255.084734] .. [<ffffffff8025ef3d>] .... __schedule+0xb3/0xb2a
  [ 3255.090753] .....[<ffffffff8025fbab>] ..   ( <=
  preempt_schedule+0x55/0x8f)
  [ 3255.097932]
  [ 3255.104620] BUG: scheduling while atomic: mv/0x00000001/5222
  [ 3255.110455]
  [ 3255.110456] Call Trace:
  [ 3255.114330]        <ffffffff8025ef25>{__schedule+155}
  [ 3255.119556]
  <ffffffff802616cb>{_raw_spin_unlock_irqrestore+81}
  [ 3255.126216]        <ffffffff80299218>{task_blocks_on_rt_mutex+497}
  [ 3255.132604]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3255.138188]        <ffffffff80291736>{find_task_by_pid_type+24}
  [ 3255.144307]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3255.149886]        <ffffffff8025fd49>{schedule+236}
  [ 3255.154930]        <ffffffff8026074f>{rt_lock_slowlock+351}
  [ 3255.160696]
  <ffffffff802616cb>{_raw_spin_unlock_irqrestore+81}
  [ 3255.167352]        <ffffffff8026113d>{__lock_text_start+13}
  [ 3255.173110]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3255.178692]
  <ffffffff802616a6>{_raw_spin_unlock_irqrestore+44}
  [ 3255.185349]        <ffffffff802a86ad>{__free_pages_ok+428}
  [ 3255.191020]        <ffffffff8022e29f>{__free_pages+48}
  [ 3255.196332]        <ffffffff802365bb>{free_pages+133}
  [ 3255.201556]        <ffffffff8025a8e3>{free_task+24}
  [ 3255.206602]        <ffffffff802474b7>{__put_task_struct+189}
  [ 3255.212451]        <ffffffff8025fa84>{thread_return+208}
  [ 3255.217945]
  <ffffffff802616cb>{_raw_spin_unlock_irqrestore+81}
  [ 3255.224603]        <ffffffff8025fbab>{preempt_schedule+85}
  [ 3255.230273]
  <ffffffff802616cb>{_raw_spin_unlock_irqrestore+81}
  [ 3255.236928]        <ffffffff802994b0>{rt_mutex_adjust_prio+50}
  [ 3255.242957]        <ffffffff80260bb5>{rt_lock_slowunlock+99}
  [ 3255.248807]        <ffffffff80261148>{rt_unlock+9}
  [ 3255.253759]        <ffffffff8020c585>{dput+213}
  [ 3255.258444]        <ffffffff80211809>{__fput+293}
  [ 3255.263311]        <ffffffff8022d4dd>{fput+20}
  [ 3255.267906]        <ffffffff8021adbe>{remove_vma+74}
  [ 3255.273041]        <ffffffff80210cf9>{do_munmap+631}
  [ 3255.278177]        <ffffffff80215f8d>{sys_munmap+64}
  [ 3255.283310]        <ffffffff8025df02>{ia32_sysret+0}
  [ 3255.288638] ---------------------------
  [ 3255.292586] | preempt count: 00000001 ]
  [ 3255.296533] | 1-level deep critical section nesting:
  [ 3255.301646] ----------------------------------------
  [ 3255.306759] .. [<ffffffff8025ef3d>] .... __schedule+0xb3/0xb2a
  [ 3255.312777] .....[<ffffffff8025fbab>] ..   ( <=
  preempt_schedule+0x55/0x8f)
  [ 3255.319959]
  [ 3256.253417] BUG: scheduling while atomic: cc1/0x00000001/5281
  [ 3256.259343]
  [ 3256.259344] Call Trace:
  [ 3256.263217]        <ffffffff8025ef25>{__schedule+155}
  [ 3256.268446]
  <ffffffff802616c2>{_raw_spin_unlock_irqrestore+72}
  [ 3256.275103]        <ffffffff80299218>{task_blocks_on_rt_mutex+497}
  [ 3256.281490]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3256.287073]        <ffffffff80291736>{find_task_by_pid_type+24}
  [ 3256.293196]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3256.298779]        <ffffffff8025fd49>{schedule+236}
  [ 3256.303824]        <ffffffff8026074f>{rt_lock_slowlock+351}
  [ 3256.309592]
  <ffffffff802616c2>{_raw_spin_unlock_irqrestore+72}
  [ 3256.316248]        <ffffffff8026113d>{__lock_text_start+13}
  [ 3256.322006]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3256.327588]
  <ffffffff802616a6>{_raw_spin_unlock_irqrestore+44}
  [ 3256.334243]        <ffffffff802a86ad>{__free_pages_ok+428}
  [ 3256.339917]        <ffffffff8022e29f>{__free_pages+48}
  [ 3256.345229]        <ffffffff802365bb>{free_pages+133}
  [ 3256.350454]        <ffffffff8025a8e3>{free_task+24}
  [ 3256.355502]        <ffffffff802474b7>{__put_task_struct+189}
  [ 3256.361353]        <ffffffff8025fa84>{thread_return+208}
  [ 3256.366852]        <ffffffff8025fd49>{schedule+236}
  [ 3256.371898]        <ffffffff8025c47f>{retint_careful+15}
  [ 3256.377586] ---------------------------
  [ 3256.381533] | preempt count: 00000001 ]
  [ 3256.385481] | 1-level deep critical section nesting:
  [ 3256.390592] ----------------------------------------
  [ 3256.395704] .. [<ffffffff8025ef3d>] .... __schedule+0xb3/0xb2a
  [ 3256.401723] .....[<ffffffff8025fd49>] ..   ( <=
  schedule+0xec/0x11e)
  [ 3256.408278]
  [ 3256.787232] BUG: scheduling while atomic: make/0x00000001/5314
  [ 3256.793246]
  [ 3256.793247] Call Trace:
  [ 3256.797118]        <ffffffff8025ef25>{__schedule+155}
  [ 3256.802342]
  <ffffffff802616c2>{_raw_spin_unlock_irqrestore+72}
  [ 3256.808998]        <ffffffff80299218>{task_blocks_on_rt_mutex+497}
  [ 3256.815386]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3256.820971]        <ffffffff80291736>{find_task_by_pid_type+24}
  [ 3256.827090]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3256.832671]        <ffffffff8025fd49>{schedule+236}
  [ 3256.837716]        <ffffffff8026074f>{rt_lock_slowlock+351}
  [ 3256.843480]
  <ffffffff802616c2>{_raw_spin_unlock_irqrestore+72}
  [ 3256.850137]        <ffffffff8026113d>{__lock_text_start+13}
  [ 3256.855898]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3256.861479]
  <ffffffff802616a6>{_raw_spin_unlock_irqrestore+44}
  [ 3256.868135]        <ffffffff802a86ad>{__free_pages_ok+428}
  [ 3256.873807]        <ffffffff8022e29f>{__free_pages+48}
  [ 3256.879121]        <ffffffff802365bb>{free_pages+133}
  [ 3256.884345]        <ffffffff8025a8e3>{free_task+24}
  [ 3256.889391]        <ffffffff802474b7>{__put_task_struct+189}
  [ 3256.895240]        <ffffffff80227a18>{schedule_tail+184}
  [ 3256.900732]        <ffffffff8025bdd1>{ret_from_fork+5}
  [ 3256.906242] ---------------------------
  [ 3256.910190] | preempt count: 00000001 ]
  [ 3256.914140] | 1-level deep critical section nesting:
  [ 3256.919250] ----------------------------------------
  [ 3256.924363] .. [<ffffffff8026129a>] .... _raw_spin_lock+0x13/0x20
  [ 3256.930650] .....[<ffffffff80260b60>] ..   ( <=
  rt_lock_slowunlock+0xe/0x67)
  [ 3256.937921]
  [ 3259.553268] BUG: scheduling while atomic: cc1/0x00000001/5428
  [ 3259.559191]
  [ 3259.559192] Call Trace:
  [ 3259.563065]        <ffffffff8025ef25>{__schedule+155}
  [ 3259.568292]
  <ffffffff802616cb>{_raw_spin_unlock_irqrestore+81}
  [ 3259.574949]        <ffffffff80299218>{task_blocks_on_rt_mutex+497}
  [ 3259.581345]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3259.586929]        <ffffffff80291736>{find_task_by_pid_type+24}
  [ 3259.593049]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3259.598630]        <ffffffff8025fd49>{schedule+236}
  [ 3259.603675]        <ffffffff8026074f>{rt_lock_slowlock+351}
  [ 3259.609441]
  <ffffffff802616cb>{_raw_spin_unlock_irqrestore+81}
  [ 3259.616100]        <ffffffff8026113d>{__lock_text_start+13}
  [ 3259.621861]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3259.627441]
  <ffffffff802616a6>{_raw_spin_unlock_irqrestore+44}
  [ 3259.634099]        <ffffffff802a86ad>{__free_pages_ok+428}
  [ 3259.639773]        <ffffffff8022e29f>{__free_pages+48}
  [ 3259.645087]        <ffffffff802365bb>{free_pages+133}
  [ 3259.650312]        <ffffffff8025a8e3>{free_task+24}
  [ 3259.655360]        <ffffffff802474b7>{__put_task_struct+189}
  [ 3259.661209]        <ffffffff8025fa84>{thread_return+208}
  [ 3259.666704]
  <ffffffff802616a6>{_raw_spin_unlock_irqrestore+44}
  [ 3259.673361]        <ffffffff8025fbab>{preempt_schedule+85}
  [ 3259.679032]        <ffffffff80261776>{_raw_spin_unlock+55}
  [ 3259.684702]        <ffffffff80260b90>{rt_lock_slowunlock+62}
  [ 3259.690550]        <ffffffff80261148>{rt_unlock+9}
  [ 3259.695503]        <ffffffff8029aa02>{atomic_dec_and_spin_lock+44}
  [ 3259.701893]        <ffffffff8020c4e9>{dput+57}
  [ 3259.706490]        <ffffffff80209396>{__link_path_walk+1617}
  [ 3259.712347]        <ffffffff8020db81>{link_path_walk+103}
  [ 3259.717931]        <ffffffff80215e38>{get_unused_fd+251}
  [ 3259.723430]        <ffffffff8020be5a>{do_path_lookup+644}
  [ 3259.729015]        <ffffffff8022360b>{__path_lookup_intent_open+89}
  [ 3259.735497]        <ffffffff802c1b0c>{path_lookup_open+12}
  [ 3259.741169]        <ffffffff8021b0c5>{open_namei+144}
  [ 3259.746398]        <ffffffff80227736>{do_filp_open+38}
  [ 3259.751719]        <ffffffff80219e0a>{do_sys_open+77}
  [ 3259.756946]        <ffffffff802d1528>{compat_sys_open+21}
  [ 3259.762527]        <ffffffff8025df02>{ia32_sysret+0}
  [ 3259.767859] ---------------------------
  [ 3259.771807] | preempt count: 00000001 ]
  [ 3259.775755] | 1-level deep critical section nesting:
  [ 3259.780867] ----------------------------------------
  [ 3259.785977] .. [<ffffffff8025ef3d>] .... __schedule+0xb3/0xb2a
  [ 3259.791996] .....[<ffffffff8025fbab>] ..   ( <=
  preempt_schedule+0x55/0x8f)
  [ 3259.799176]
  [ 3259.803837] BUG: scheduling while atomic: cc1/0x00000001/5428
  [ 3259.809760]
  [ 3259.809761] Call Trace:
  [ 3259.813633]        <ffffffff8025ef25>{__schedule+155}
  [ 3259.818863]        <ffffffff80299218>{task_blocks_on_rt_mutex+497}
  [ 3259.825250]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3259.830832]        <ffffffff80291736>{find_task_by_pid_type+24}
  [ 3259.836953]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3259.842535]        <ffffffff8025fd49>{schedule+236}
  [ 3259.847578]        <ffffffff8026074f>{rt_lock_slowlock+351}
  [ 3259.853351]
  <ffffffff802616cb>{_raw_spin_unlock_irqrestore+81}
  [ 3259.860008]        <ffffffff8026113d>{__lock_text_start+13}
  [ 3259.865768]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3259.871350]
  <ffffffff802616a6>{_raw_spin_unlock_irqrestore+44}
  [ 3259.878008]        <ffffffff802a86ad>{__free_pages_ok+428}
  [ 3259.883683]        <ffffffff8022e29f>{__free_pages+48}
  [ 3259.888995]        <ffffffff802365bb>{free_pages+133}
  [ 3259.894221]        <ffffffff8025a8e3>{free_task+24}
  [ 3259.899266]        <ffffffff802474b7>{__put_task_struct+189}
  [ 3259.905115]        <ffffffff8025fa84>{thread_return+208}
  [ 3259.910610]
  <ffffffff802616a6>{_raw_spin_unlock_irqrestore+44}
  [ 3259.917271]        <ffffffff8025fbab>{preempt_schedule+85}
  [ 3259.922940]        <ffffffff80261776>{_raw_spin_unlock+55}
  [ 3259.928610]        <ffffffff80260b90>{rt_lock_slowunlock+62}
  [ 3259.934459]        <ffffffff80261148>{rt_unlock+9}
  [ 3259.939414]        <ffffffff8029aa02>{atomic_dec_and_spin_lock+44}
  [ 3259.945802]        <ffffffff8020c4e9>{dput+57}
  [ 3259.950402]        <ffffffff80209396>{__link_path_walk+1617}
  [ 3259.956257]        <ffffffff8020db81>{link_path_walk+103}
  [ 3259.961841]        <ffffffff80215e38>{get_unused_fd+251}
  [ 3259.967340]        <ffffffff8020be5a>{do_path_lookup+644}
  [ 3259.972924]        <ffffffff8022360b>{__path_lookup_intent_open+89}
  [ 3259.979402]        <ffffffff802c1b0c>{path_lookup_open+12}
  [ 3259.985073]        <ffffffff8021b0c5>{open_namei+144}
  [ 3259.990303]        <ffffffff80227736>{do_filp_open+38}
  [ 3259.995622]        <ffffffff80219e0a>{do_sys_open+77}
  [ 3260.000849]        <ffffffff802d1528>{compat_sys_open+21}
  [ 3260.006431]        <ffffffff8025df02>{ia32_sysret+0}
  [ 3260.011762] ---------------------------
  [ 3260.015710] | preempt count: 00000001 ]
  [ 3260.019657] | 1-level deep critical section nesting:
  [ 3260.024769] ----------------------------------------
  [ 3260.029881] .. [<ffffffff8025ef3d>] .... __schedule+0xb3/0xb2a
  [ 3260.035898] .....[<ffffffff8025fbab>] ..   ( <=
  preempt_schedule+0x55/0x8f)
  [ 3260.043077]
  [ 3273.447899] BUG: scheduling while atomic: ld/0x00000001/6045
  [ 3273.453733]
  [ 3273.453734] Call Trace:
  [ 3273.457608]        <ffffffff8025ef25>{__schedule+155}
  [ 3273.462836]
  <ffffffff802616cb>{_raw_spin_unlock_irqrestore+81}
  [ 3273.469496]        <ffffffff80299218>{task_blocks_on_rt_mutex+497}
  [ 3273.475884]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3273.481468]        <ffffffff80291736>{find_task_by_pid_type+24}
  [ 3273.487589]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3273.493172]        <ffffffff8025fd49>{schedule+236}
  [ 3273.498216]        <ffffffff8026074f>{rt_lock_slowlock+351}
  [ 3273.503985]
  <ffffffff802616cb>{_raw_spin_unlock_irqrestore+81}
  [ 3273.510642]        <ffffffff8026113d>{__lock_text_start+13}
  [ 3273.516403]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3273.521985]
  <ffffffff802616a6>{_raw_spin_unlock_irqrestore+44}
  [ 3273.528641]        <ffffffff802a86ad>{__free_pages_ok+428}
  [ 3273.534317]        <ffffffff8022e29f>{__free_pages+48}
  [ 3273.539630]        <ffffffff802365bb>{free_pages+133}
  [ 3273.544855]        <ffffffff8025a8e3>{free_task+24}
  [ 3273.549900]        <ffffffff802474b7>{__put_task_struct+189}
  [ 3273.555753]        <ffffffff8025fa84>{thread_return+208}
  [ 3273.561250]
  <ffffffff802616cb>{_raw_spin_unlock_irqrestore+81}
  [ 3273.567907]        <ffffffff8025fbab>{preempt_schedule+85}
  [ 3273.573578]
  <ffffffff802616cb>{_raw_spin_unlock_irqrestore+81}
  [ 3273.580234]        <ffffffff802994b0>{rt_mutex_adjust_prio+50}
  [ 3273.586264]        <ffffffff80260bb5>{rt_lock_slowunlock+99}
  [ 3273.592114]        <ffffffff80261148>{rt_unlock+9}
  [ 3273.597071]        <ffffffff8020fb7c>{__mod_page_state_offset+100}
  [ 3273.603466]        <ffffffff8020e887>{mod_page_state_offset+73}
  [ 3273.609585]        <ffffffff80208378>{__handle_mm_fault+62}
  [ 3273.615346]        <ffffffff80299473>{rt_mutex_slowtrylock+144}
  [ 3273.621467]        <ffffffff802638ba>{do_page_fault+1072}
  [ 3273.627054]        <ffffffff8025fa8e>{thread_return+218}
  [ 3273.632551]        <ffffffff8025cdf5>{error_exit+0}
  [ 3273.637796] ---------------------------
  [ 3273.641743] | preempt count: 00000001 ]
  [ 3273.645692] | 1-level deep critical section nesting:
  [ 3273.650803] ----------------------------------------
  [ 3273.655915] .. [<ffffffff8025ef3d>] .... __schedule+0xb3/0xb2a
  [ 3273.661932] .....[<ffffffff8025fbab>] ..   ( <=
  preempt_schedule+0x55/0x8f)
  [ 3273.669113]
  [ 3294.784449] BUG: scheduling while atomic: make/0x00000001/7072
  [ 3294.790461]
  [ 3294.790462] Call Trace:
  [ 3294.794335]        <ffffffff8025ef25>{__schedule+155}
  [ 3294.799564]
  <ffffffff802616c2>{_raw_spin_unlock_irqrestore+72}
  [ 3294.806221]        <ffffffff80299218>{task_blocks_on_rt_mutex+497}
  [ 3294.812608]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3294.818190]        <ffffffff80291736>{find_task_by_pid_type+24}
  [ 3294.824309]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3294.829889]        <ffffffff8025fd49>{schedule+236}
  [ 3294.834936]        <ffffffff8026074f>{rt_lock_slowlock+351}
  [ 3294.840701]
  <ffffffff802616c2>{_raw_spin_unlock_irqrestore+72}
  [ 3294.847356]        <ffffffff8026113d>{__lock_text_start+13}
  [ 3294.853114]        <ffffffff802a81f7>{free_pages_bulk+42}
  [ 3294.858696]
  <ffffffff802616a6>{_raw_spin_unlock_irqrestore+44}
  [ 3294.865354]        <ffffffff802a86ad>{__free_pages_ok+428}
  [ 3294.871027]        <ffffffff8022e29f>{__free_pages+48}
  [ 3294.876340]        <ffffffff802365bb>{free_pages+133}
  [ 3294.881565]        <ffffffff8025a8e3>{free_task+24}
  [ 3294.886619]        <ffffffff802474b7>{__put_task_struct+189}
  [ 3294.892471]        <ffffffff80227a18>{schedule_tail+184}
  [ 3294.897964]        <ffffffff8025bdd1>{ret_from_fork+5}
  [ 3294.903475] ---------------------------
  [ 3294.907424] | preempt count: 00000001 ]
  [ 3294.911372] | 1-level deep critical section nesting:
  [ 3294.916484] ----------------------------------------
  [ 3294.921595] .. [<ffffffff8026129a>] .... _raw_spin_lock+0x13/0x20
  [ 3294.927883] .....[<ffffffff80260b60>] ..   ( <=
  rt_lock_slowunlock+0xe/0x67)
  [ 3294.935155]
  [ 3309.174697] B

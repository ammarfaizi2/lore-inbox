Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751207AbWFFB73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWFFB73 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 21:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWFFB73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 21:59:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:6940 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751207AbWFFB72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 21:59:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Yc78mrYiWCMUt3qFJNmEHuoIS9JMdAKu5kGqfr8STf4KycUqVuIF0anLVIpGN3zYBUuSNIgTOWEwR1TfE1khH/Zc4IQXsQCZoaEjSZ1xWMZzeHJjCsqcnGitMmDR6vfHBC9E2mZjVSz0TMRGtDYqlwyM4SpxXSmsnDomeSigw34=
Date: Tue, 6 Jun 2006 03:58:33 +0200
From: Diego Calleja <diegocg@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, nathans@sgi.com, davem@davemloft.net
Subject: [RFC] Update sysctl documentation
Message-Id: <20060606035833.bee909af.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I promised, I've updated all the documentation concerning sysctls.

First of all: the formatting I've choosen is to recreate the structure
of /proc/sys/* and put the documentation for every value in a separated
file, so I have things like Documentation/sysctl/vm/swappiness or
Documentation/sysctl/net/ipv4/locktime. For the particular case of 
sysctls, recreating the /proc structure looked to me much easier and
intuitive (the included diffstat gives a mental image of it). If people
doesn't like it I can put it back in big .txt files, but cat +
tab completion looked to me a better idea.

I've also moved all the networking sysctls I found (oh, and XFS, both
CCed) to Documentation/sysctl. I don't know if the networking and XFS
people want this, but I think it's the Right Thing to have all the
sysctl documentation in a single place.

I've also deleted the "chapter 2" of Documentation/filesystems/proc.txt,
which is about sysctls (and is outdated anyway) and I've moved it to
Documentation/sysctl/ and updated all I could update. I've deleted
documentation about sysctls that don't exist in the tree anymore,
I've added some sysctls that were not documented, I've added lots
of sysctls that exist but I don't know what they're doing (they've 
a "TODO" inside them), and there're still tons of sysctls in
drivers/ and net/ that still need to be documented. I've not
updated /proc/sys/dev/ because AFAIK that info wants to be moved
to sysfs anyway.



With all this we get a more-or-less updated documentation of all the
sysctl available, clean up some 2.2 crap that was still hanging
around, kills lots of documentation that was duplicated for no reason
and centralize all the sysctl documentation in a single place.


The patch is diffed against current Linus' tree (I can rediff against
-mm if neccesary, but I though nobody would want that for this patch),
weights around 250 KB and can be found at http://terra.es/personal/diegocg/sysctl-docs

 2.6/Documentation/filesystems/proc.txt                              | 1210 ----------
 2.6/Documentation/filesystems/xfs.txt                               |   84 
 2.6/Documentation/networking/00-INDEX                               |    2 
 2.6/Documentation/networking/Configurable                           |    2 
 2.6/Documentation/networking/decnet.txt                             |    4 
 2.6/Documentation/networking/ip-sysctl.txt                          |  899 -------
 2.6/Documentation/networking/xfrm_sync.txt                          |   11 
 2.6/Documentation/sysctl/README                                     |   17 
 2.6/Documentation/sysctl/dev/README                                 |    2 
 2.6/Documentation/sysctl/fs/README                                  |    8 
 2.6/Documentation/sysctl/fs/aio-max-nr                              |    2 
 2.6/Documentation/sysctl/fs/aio-nr                                  |    2 
 2.6/Documentation/sysctl/fs/binfmt_misc                             |    1 
 2.6/Documentation/sysctl/fs/dentry-state                            |   19 
 2.6/Documentation/sysctl/fs/dir-notify-enable                       |   10 
 2.6/Documentation/sysctl/fs/dquot-max                               |    7 
 2.6/Documentation/sysctl/fs/dquot-nr                                |    7 
 2.6/Documentation/sysctl/fs/file-max                                |    6 
 2.6/Documentation/sysctl/fs/file-nr                                 |    6 
 2.6/Documentation/sysctl/fs/inode-nr                                |    3 
 2.6/Documentation/sysctl/fs/inode-state                             |    9 
 2.6/Documentation/sysctl/fs/inotify                                 |    1 
 2.6/Documentation/sysctl/fs/lease-break-time                        |    1 
 2.6/Documentation/sysctl/fs/mqueue/msg_max                          |    3 
 2.6/Documentation/sysctl/fs/mqueue/msgsize_max                      |    2 
 2.6/Documentation/sysctl/fs/mqueue/queues_max                       |    1 
 2.6/Documentation/sysctl/fs/overflowgid                             |    6 
 2.6/Documentation/sysctl/fs/overflowuid                             |    6 
 2.6/Documentation/sysctl/fs/suid_dumpable                           |   14 
 2.6/Documentation/sysctl/fs/xfs/README                              |    1 
 2.6/Documentation/sysctl/fs/xfs/age_buffer_centisecs                |    3 
 2.6/Documentation/sysctl/fs/xfs/error_level                         |    8 
 2.6/Documentation/sysctl/fs/xfs/inherit_noatime                     |    5 
 2.6/Documentation/sysctl/fs/xfs/inherit_nodump                      |    5 
 2.6/Documentation/sysctl/fs/xfs/inherit_nosymlinks                  |    5 
 2.6/Documentation/sysctl/fs/xfs/inherit_sync                        |    5 
 2.6/Documentation/sysctl/fs/xfs/irix_sgid_inherit                   |    7 
 2.6/Documentation/sysctl/fs/xfs/irix_symlink_mode                   |    4 
 2.6/Documentation/sysctl/fs/xfs/panic_mask                          |   14 
 2.6/Documentation/sysctl/fs/xfs/restrict_chown                      |    4 
 2.6/Documentation/sysctl/fs/xfs/rotorstep                           |    7 
 2.6/Documentation/sysctl/fs/xfs/stats_clear                         |    4 
 2.6/Documentation/sysctl/fs/xfs/xfsbufd_centisecs                   |    3 
 2.6/Documentation/sysctl/fs/xfs/xfssyncd_centisecs                  |    5 
 2.6/Documentation/sysctl/kernel/README                              |    8 
 2.6/Documentation/sysctl/kernel/acct                                |   16 
 2.6/Documentation/sysctl/kernel/acpi_video_flags                    |    4 
 2.6/Documentation/sysctl/kernel/bootloader_type                     |    2 
 2.6/Documentation/sysctl/kernel/cad_pid                             |    1 
 2.6/Documentation/sysctl/kernel/cap-bound                           |    1 
 2.6/Documentation/sysctl/kernel/core_pattern                        |   20 
 2.6/Documentation/sysctl/kernel/core_uses_pid                       |    5 
 2.6/Documentation/sysctl/kernel/ctrl-alt-del                        |   10 
 2.6/Documentation/sysctl/kernel/domainname                          |   12 
 2.6/Documentation/sysctl/kernel/hostname                            |   12 
 2.6/Documentation/sysctl/kernel/hotplug                             |    1 
 2.6/Documentation/sysctl/kernel/hz_timer                            |    5 
 2.6/Documentation/sysctl/kernel/ieee_emulation_warnings             |    3 
 2.6/Documentation/sysctl/kernel/ignore-unaligned-usertrap           |    4 
 2.6/Documentation/sysctl/kernel/l2cr                                |    4 
 2.6/Documentation/sysctl/kernel/modprobe                            |    2 
 2.6/Documentation/sysctl/kernel/msgmax                              |    1 
 2.6/Documentation/sysctl/kernel/msgmnb                              |    1 
 2.6/Documentation/sysctl/kernel/msgmni                              |    1 
 2.6/Documentation/sysctl/kernel/ngroups_max                         |    1 
 2.6/Documentation/sysctl/kernel/nmi_watchdog                        |    6 
 2.6/Documentation/sysctl/kernel/osrelease                           |    1 
 2.6/Documentation/sysctl/kernel/ostype                              |    1 
 2.6/Documentation/sysctl/kernel/overflowgid                         |    6 
 2.6/Documentation/sysctl/kernel/overflowuid                         |    6 
 2.6/Documentation/sysctl/kernel/panic                               |    5 
 2.6/Documentation/sysctl/kernel/panic_on_oops                       |    7 
 2.6/Documentation/sysctl/kernel/pid_max                             |    3 
 2.6/Documentation/sysctl/kernel/powersave-nap                       |    4 
 2.6/Documentation/sysctl/kernel/printk                              |   16 
 2.6/Documentation/sysctl/kernel/printk_ratelimit                    |    5 
 2.6/Documentation/sysctl/kernel/printk_ratelimit_burst              |    4 
 2.6/Documentation/sysctl/kernel/pty                                 |    1 
 2.6/Documentation/sysctl/kernel/random                              |    1 
 2.6/Documentation/sysctl/kernel/randomize_va_space                  |    1 
 2.6/Documentation/sysctl/kernel/real-root-dev                       |    1 
 2.6/Documentation/sysctl/kernel/reboot-cmd                          |    5 
 2.6/Documentation/sysctl/kernel/rtsig-max                           |    3 
 2.6/Documentation/sysctl/kernel/rtsig-nr                            |    1 
 2.6/Documentation/sysctl/kernel/scons-poweroff                      |    3 
 2.6/Documentation/sysctl/kernel/sem                                 |    1 
 2.6/Documentation/sysctl/kernel/sg-big-buff                         |    4 
 2.6/Documentation/sysctl/kernel/shmall                              |    1 
 2.6/Documentation/sysctl/kernel/shmmax                              |    4 
 2.6/Documentation/sysctl/kernel/shmmni                              |    1 
 2.6/Documentation/sysctl/kernel/soft-power                          |    3 
 2.6/Documentation/sysctl/kernel/spin_retry                          |    4 
 2.6/Documentation/sysctl/kernel/stop-a                              |    3 
 2.6/Documentation/sysctl/kernel/sysrq                               |    1 
 2.6/Documentation/sysctl/kernel/tainted                             |    9 
 2.6/Documentation/sysctl/kernel/threads-max                         |    1 
 2.6/Documentation/sysctl/kernel/unaligned-trap                      |    3 
 2.6/Documentation/sysctl/kernel/unknow_nmi_panic                    |    6 
 2.6/Documentation/sysctl/kernel/userprocess_debug                   |    3 
 2.6/Documentation/sysctl/kernel/version                             |    6 
 2.6/Documentation/sysctl/net/README                                 |    8 
 2.6/Documentation/sysctl/net/appletalk/README                       |    2 
 2.6/Documentation/sysctl/net/appletalk/aarp-expiry-time             |    2 
 2.6/Documentation/sysctl/net/appletalk/aarp-resolve-time            |    1 
 2.6/Documentation/sysctl/net/appletalk/aarp-retransmit-limit        |    1 
 2.6/Documentation/sysctl/net/appletalk/aarp-tick-time               |    1 
 2.6/Documentation/sysctl/net/bridge/README                          |    1 
 2.6/Documentation/sysctl/net/bridge/bridge-nf-call-arptables        |    3 
 2.6/Documentation/sysctl/net/bridge/bridge-nf-call-ip6tables        |    3 
 2.6/Documentation/sysctl/net/bridge/bridge-nf-call-iptables         |    3 
 2.6/Documentation/sysctl/net/bridge/bridge-nf-filter-vlan-tagged    |    3 
 2.6/Documentation/sysctl/net/core/dev_weight                        |    1 
 2.6/Documentation/sysctl/net/core/message_burst                     |    6 
 2.6/Documentation/sysctl/net/core/message_cost                      |    5 
 2.6/Documentation/sysctl/net/core/netdev_budget                     |    1 
 2.6/Documentation/sysctl/net/core/netdev_max_backlog                |    2 
 2.6/Documentation/sysctl/net/core/optmem_max                        |    2 
 2.6/Documentation/sysctl/net/core/rmem_default                      |    1 
 2.6/Documentation/sysctl/net/core/rmem_max                          |    1 
 2.6/Documentation/sysctl/net/core/somaxconn                         |    3 
 2.6/Documentation/sysctl/net/core/wmem_default                      |    1 
 2.6/Documentation/sysctl/net/core/wmem_max                          |    1 
 2.6/Documentation/sysctl/net/core/xfrm_aevent_etime                 |    2 
 2.6/Documentation/sysctl/net/core/xfrm_aevent_rseqth                |    2 
 2.6/Documentation/sysctl/net/ipv4/README                            |    2 
 2.6/Documentation/sysctl/net/ipv4/conf/README                       |   27 
 2.6/Documentation/sysctl/net/ipv4/icmp_echo_ignore_all              |    1 
 2.6/Documentation/sysctl/net/ipv4/icmp_echo_ignore_broadcasts       |    7 
 2.6/Documentation/sysctl/net/ipv4/icmp_errors_use_inbound_ifaddr    |   14 
 2.6/Documentation/sysctl/net/ipv4/icmp_ignore_bogus_error_responses |    5 
 2.6/Documentation/sysctl/net/ipv4/icmp_ratelimit                    |    4 
 2.6/Documentation/sysctl/net/ipv4/icmp_ratemask                     |   20 
 2.6/Documentation/sysctl/net/ipv4/igmp_max_memberships              |    2 
 2.6/Documentation/sysctl/net/ipv4/igmp_max_msf                      |    1 
 2.6/Documentation/sysctl/net/ipv4/inet_peer_gc_maxtime              |    3 
 2.6/Documentation/sysctl/net/ipv4/inet_peer_gc_mintime              |    3 
 2.6/Documentation/sysctl/net/ipv4/inet_peer_maxttl                  |    4 
 2.6/Documentation/sysctl/net/ipv4/inet_peer_minttl                  |    4 
 2.6/Documentation/sysctl/net/ipv4/inet_peer_threshold               |    4 
 2.6/Documentation/sysctl/net/ipv4/ip_autoconfig                     |    2 
 2.6/Documentation/sysctl/net/ipv4/ip_conntrack_max                  |    1 
 2.6/Documentation/sysctl/net/ipv4/ip_default_ttl                    |    2 
 2.6/Documentation/sysctl/net/ipv4/ip_dynaddr                        |    5 
 2.6/Documentation/sysctl/net/ipv4/ip_forward                        |    5 
 2.6/Documentation/sysctl/net/ipv4/ip_local_port_range               |   11 
 2.6/Documentation/sysctl/net/ipv4/ip_no_pmtu_disc                   |    2 
 2.6/Documentation/sysctl/net/ipv4/ip_nonlocal_bind                  |    3 
 2.6/Documentation/sysctl/net/ipv4/ipfrag_high_thresh                |    3 
 2.6/Documentation/sysctl/net/ipv4/ipfrag_low_thresh                 |    2 
 2.6/Documentation/sysctl/net/ipv4/ipfrag_max_dist                   |   21 
 2.6/Documentation/sysctl/net/ipv4/ipfrag_secret_interval            |    3 
 2.6/Documentation/sysctl/net/ipv4/ipfrag_time                       |    1 
 2.6/Documentation/sysctl/net/ipv4/neigh/README                      |    9 
 2.6/Documentation/sysctl/net/ipv4/neigh/anycast_delay               |    1 
 2.6/Documentation/sysctl/net/ipv4/neigh/app_solicit                 |    1 
 2.6/Documentation/sysctl/net/ipv4/neigh/base_reachable_time         |    1 
 2.6/Documentation/sysctl/net/ipv4/neigh/base_reachable_time_ms      |    1 
 2.6/Documentation/sysctl/net/ipv4/neigh/delay_first_probe_time      |    1 
 2.6/Documentation/sysctl/net/ipv4/neigh/gc_interval                 |    1 
 2.6/Documentation/sysctl/net/ipv4/neigh/gc_stale_time               |    1 
 2.6/Documentation/sysctl/net/ipv4/neigh/gc_thresh1                  |    1 
 2.6/Documentation/sysctl/net/ipv4/neigh/gc_thresh2                  |    1 
 2.6/Documentation/sysctl/net/ipv4/neigh/gc_thresh3                  |    1 
 2.6/Documentation/sysctl/net/ipv4/neigh/locktime                    |    1 
 2.6/Documentation/sysctl/net/ipv4/neigh/mcast_solicit               |    1 
 2.6/Documentation/sysctl/net/ipv4/neigh/proxy_delay                 |    1 
 2.6/Documentation/sysctl/net/ipv4/neigh/proxy_qlen                  |    1 
 2.6/Documentation/sysctl/net/ipv4/neigh/retrans_time                |    1 
 2.6/Documentation/sysctl/net/ipv4/neigh/retrans_time_ms             |    1 
 2.6/Documentation/sysctl/net/ipv4/neigh/ucast_solicit               |    1 
 2.6/Documentation/sysctl/net/ipv4/neigh/unres_qlen                  |    1 
 2.6/Documentation/sysctl/net/ipv4/route/error_burst                 |    1 
 2.6/Documentation/sysctl/net/ipv4/route/error_cost                  |    1 
 2.6/Documentation/sysctl/net/ipv4/route/flush                       |    1 
 2.6/Documentation/sysctl/net/ipv4/route/gc_elasticity               |    1 
 2.6/Documentation/sysctl/net/ipv4/route/gc_interval                 |    1 
 2.6/Documentation/sysctl/net/ipv4/route/gc_min_interval             |    1 
 2.6/Documentation/sysctl/net/ipv4/route/gc_min_interval_ms          |    1 
 2.6/Documentation/sysctl/net/ipv4/route/gc_thresh                   |    1 
 2.6/Documentation/sysctl/net/ipv4/route/gc_timeout                  |    1 
 2.6/Documentation/sysctl/net/ipv4/route/max_delay                   |    1 
 2.6/Documentation/sysctl/net/ipv4/route/max_size                    |    1 
 2.6/Documentation/sysctl/net/ipv4/route/min_adv_mss                 |    2 
 2.6/Documentation/sysctl/net/ipv4/route/min_delay                   |    1 
 2.6/Documentation/sysctl/net/ipv4/route/min_pmtu                    |    1 
 2.6/Documentation/sysctl/net/ipv4/route/mtu_expires                 |    1 
 2.6/Documentation/sysctl/net/ipv4/route/redirect_load               |    1 
 2.6/Documentation/sysctl/net/ipv4/route/redirect_number             |    1 
 2.6/Documentation/sysctl/net/ipv4/route/redirect_silence            |    1 
 2.6/Documentation/sysctl/net/ipv4/route/secret_interval             |    1 
 2.6/Documentation/sysctl/net/ipv4/tcp_abc                           |    3 
 2.6/Documentation/sysctl/net/ipv4/tcp_abort_on_overflow             |    6 
 2.6/Documentation/sysctl/net/ipv4/tcp_adv_win_scale                 |    4 
 2.6/Documentation/sysctl/net/ipv4/tcp_app_win                       |    3 
 2.6/Documentation/sysctl/net/ipv4/tcp_base_mss                      |    1 
 2.6/Documentation/sysctl/net/ipv4/tcp_congestion_control            |    4 
 2.6/Documentation/sysctl/net/ipv4/tcp_dsack                         |    1 
 2.6/Documentation/sysctl/net/ipv4/tcp_ecn                           |    5 
 2.6/Documentation/sysctl/net/ipv4/tcp_fack                          |    2 
 2.6/Documentation/sysctl/net/ipv4/tcp_fin_timeout                   |    9 
 2.6/Documentation/sysctl/net/ipv4/tcp_frto                          |    4 
 2.6/Documentation/sysctl/net/ipv4/tcp_keepalive_intvl               |    4 
 2.6/Documentation/sysctl/net/ipv4/tcp_keepalive_probes              |    2 
 2.6/Documentation/sysctl/net/ipv4/tcp_keepalive_time                |    2 
 2.6/Documentation/sysctl/net/ipv4/tcp_low_latency                   |    6 
 2.6/Documentation/sysctl/net/ipv4/tcp_max_orphans                   |   10 
 2.6/Documentation/sysctl/net/ipv4/tcp_max_syn_backlog               |    5 
 2.6/Documentation/sysctl/net/ipv4/tcp_max_tw_buckets                |    6 
 2.6/Documentation/sysctl/net/ipv4/tcp_mem                           |   12 
 2.6/Documentation/sysctl/net/ipv4/tcp_moderate_rcvbuf               |    1 
 2.6/Documentation/sysctl/net/ipv4/tcp_mtu_probing                   |    1 
 2.6/Documentation/sysctl/net/ipv4/tcp_no_metrics_save               |    1 
 2.6/Documentation/sysctl/net/ipv4/tcp_orphan_retries                |    5 
 2.6/Documentation/sysctl/net/ipv4/tcp_reordering                    |    2 
 2.6/Documentation/sysctl/net/ipv4/tcp_retrans_collapse              |    3 
 2.6/Documentation/sysctl/net/ipv4/tcp_retries1                      |    4 
 2.6/Documentation/sysctl/net/ipv4/tcp_retries2                      |    4 
 2.6/Documentation/sysctl/net/ipv4/tcp_rfc1337                       |    4 
 2.6/Documentation/sysctl/net/ipv4/tcp_rmem                          |   16 
 2.6/Documentation/sysctl/net/ipv4/tcp_sack                          |    1 
 2.6/Documentation/sysctl/net/ipv4/tcp_stdurg                        |    5 
 2.6/Documentation/sysctl/net/ipv4/tcp_syn_retries                   |    4 
 2.6/Documentation/sysctl/net/ipv4/tcp_synack_retries                |    3 
 2.6/Documentation/sysctl/net/ipv4/tcp_syncookies                    |   19 
 2.6/Documentation/sysctl/net/ipv4/tcp_timestamps                    |    1 
 2.6/Documentation/sysctl/net/ipv4/tcp_tso_win_divisor               |    5 
 2.6/Documentation/sysctl/net/ipv4/tcp_tw_recycle                    |    3 
 2.6/Documentation/sysctl/net/ipv4/tcp_tw_reuse                      |    4 
 2.6/Documentation/sysctl/net/ipv4/tcp_window_scaling                |    1 
 2.6/Documentation/sysctl/net/ipv4/tcp_wmem                          |   14 
 2.6/Documentation/sysctl/net/ipv4/tcp_workaround_signed_windows     |    5 
 2.6/Documentation/sysctl/net/ipv6/README                            |    4 
 2.6/Documentation/sysctl/net/ipv6/bindv6only                        |    7 
 2.6/Documentation/sysctl/net/ipv6/conf/README                       |   30 
 2.6/Documentation/sysctl/net/ipv6/conf/accept_ra                    |    4 
 2.6/Documentation/sysctl/net/ipv6/conf/accept_ra_defrtr             |    4 
 2.6/Documentation/sysctl/net/ipv6/conf/accept_ra_pinfo              |    4 
 2.6/Documentation/sysctl/net/ipv6/conf/accept_ra_rt_info_max_plen   |    7 
 2.6/Documentation/sysctl/net/ipv6/conf/accept_ra_rtr_pref           |    4 
 2.6/Documentation/sysctl/net/ipv6/conf/accept_redirects             |    4 
 2.6/Documentation/sysctl/net/ipv6/conf/autoconf                     |    5 
 2.6/Documentation/sysctl/net/ipv6/conf/dad_transmits                |    2 
 2.6/Documentation/sysctl/net/ipv6/conf/forwarding                   |   39 
 2.6/Documentation/sysctl/net/ipv6/conf/hop_limit                    |    2 
 2.6/Documentation/sysctl/net/ipv6/conf/max_addresses                |    5 
 2.6/Documentation/sysctl/net/ipv6/conf/max_desync_factor            |    5 
 2.6/Documentation/sysctl/net/ipv6/conf/mtu                          |    2 
 2.6/Documentation/sysctl/net/ipv6/conf/regen_max_retry              |    3 
 2.6/Documentation/sysctl/net/ipv6/conf/router_probe_interval        |    4 
 2.6/Documentation/sysctl/net/ipv6/conf/router_solicitation_delay    |    3 
 2.6/Documentation/sysctl/net/ipv6/conf/router_solicitation_interval |    2 
 2.6/Documentation/sysctl/net/ipv6/conf/router_solicitations         |    3 
 2.6/Documentation/sysctl/net/ipv6/conf/temp_prefered_lft            |    2 
 2.6/Documentation/sysctl/net/ipv6/conf/temp_valid_lft               |    2 
 2.6/Documentation/sysctl/net/ipv6/conf/use_tempaddr                 |    9 
 2.6/Documentation/sysctl/net/ipv6/icmp/ratelimit                    |    3 
 2.6/Documentation/sysctl/net/ipv6/ip6frag_high_thresh               |    4 
 2.6/Documentation/sysctl/net/ipv6/ip6frag_low_thresh                |    1 
 2.6/Documentation/sysctl/net/ipv6/ip6frag_secret_interval           |    3 
 2.6/Documentation/sysctl/net/ipv6/ip6frag_time                      |    1 
 2.6/Documentation/sysctl/net/ipv6/mld_max_msf                       |    1 
 2.6/Documentation/sysctl/net/ipv6/neigh/README                      |    1 
 2.6/Documentation/sysctl/net/ipv6/neigh/anycast_delay               |    1 
 2.6/Documentation/sysctl/net/ipv6/neigh/app_solicit                 |    1 
 2.6/Documentation/sysctl/net/ipv6/neigh/base_reachable_time         |    1 
 2.6/Documentation/sysctl/net/ipv6/neigh/base_reachable_time_ms      |    1 
 2.6/Documentation/sysctl/net/ipv6/neigh/delay_first_probe_time      |    1 
 2.6/Documentation/sysctl/net/ipv6/neigh/gc_interval                 |    1 
 2.6/Documentation/sysctl/net/ipv6/neigh/gc_stale_time               |    1 
 2.6/Documentation/sysctl/net/ipv6/neigh/gc_thresh1                  |    1 
 2.6/Documentation/sysctl/net/ipv6/neigh/gc_thresh2                  |    1 
 2.6/Documentation/sysctl/net/ipv6/neigh/gc_thresh3                  |    1 
 2.6/Documentation/sysctl/net/ipv6/neigh/locktime                    |    1 
 2.6/Documentation/sysctl/net/ipv6/neigh/mcast_solicit               |    1 
 2.6/Documentation/sysctl/net/ipv6/neigh/proxy_delay                 |    1 
 2.6/Documentation/sysctl/net/ipv6/neigh/proxy_qlen                  |    1 
 2.6/Documentation/sysctl/net/ipv6/neigh/retrans_time                |    1 
 2.6/Documentation/sysctl/net/ipv6/neigh/retrans_time_ms             |    1 
 2.6/Documentation/sysctl/net/ipv6/neigh/ucast_solicit               |    1 
 2.6/Documentation/sysctl/net/ipv6/neigh/unres_qlen                  |    1 
 2.6/Documentation/sysctl/net/ipv6/route/flush                       |    1 
 2.6/Documentation/sysctl/net/ipv6/route/gc_elasticity               |    1 
 2.6/Documentation/sysctl/net/ipv6/route/gc_interval                 |    1 
 2.6/Documentation/sysctl/net/ipv6/route/gc_min_interval             |    1 
 2.6/Documentation/sysctl/net/ipv6/route/gc_min_interval_ms          |    1 
 2.6/Documentation/sysctl/net/ipv6/route/gc_thresh                   |    1 
 2.6/Documentation/sysctl/net/ipv6/route/gc_timeout                  |    1 
 2.6/Documentation/sysctl/net/ipv6/route/max_size                    |    1 
 2.6/Documentation/sysctl/net/ipv6/route/min_adv_mss                 |    1 
 2.6/Documentation/sysctl/net/ipv6/route/mtu_expires                 |    1 
 2.6/Documentation/sysctl/net/unix/max_dgram_qlen                    |    1 
 2.6/Documentation/sysctl/sunrpc/README                              |    2 
 2.6/Documentation/sysctl/sunrpc/max_resvport                        |    1 
 2.6/Documentation/sysctl/sunrpc/min_resvport                        |    1 
 2.6/Documentation/sysctl/sunrpc/nfs_debug                           |    1 
 2.6/Documentation/sysctl/sunrpc/nfsd_debug                          |    1 
 2.6/Documentation/sysctl/sunrpc/nlm_debug                           |    1 
 2.6/Documentation/sysctl/sunrpc/rpc_debug                           |    1 
 2.6/Documentation/sysctl/sunrpc/tcp_slot_table_entries              |    1 
 2.6/Documentation/sysctl/sunrpc/udp_slot_table_entries              |    1 
 2.6/Documentation/sysctl/vm/README                                  |    8 
 2.6/Documentation/sysctl/vm/block_dump                              |    2 
 2.6/Documentation/sysctl/vm/dirty_background_ratio                  |    2 
 2.6/Documentation/sysctl/vm/dirty_expire_centisecs                  |    4 
 2.6/Documentation/sysctl/vm/dirty_ratio                             |    3 
 2.6/Documentation/sysctl/vm/dirty_writeback_centisecs               |    5 
 2.6/Documentation/sysctl/vm/drop_caches                             |   12 
 2.6/Documentation/sysctl/vm/hugetlb_shm_group                       |    2 
 2.6/Documentation/sysctl/vm/laptop_mode                             |    2 
 2.6/Documentation/sysctl/vm/legacy_va_layout                        |    2 
 2.6/Documentation/sysctl/vm/lowmem_reserve_ratio                    |    1 
 2.6/Documentation/sysctl/vm/max_map_count                           |   10 
 2.6/Documentation/sysctl/vm/min_free_kbytes                         |    4 
 2.6/Documentation/sysctl/vm/nr_hugepages                            |    1 
 2.6/Documentation/sysctl/vm/nr_pdflush_threads                      |    1 
 2.6/Documentation/sysctl/vm/overcommit_memory                       |   27 
 2.6/Documentation/sysctl/vm/overcommit_ratio                        |    7 
 2.6/Documentation/sysctl/vm/page-cluster                            |    9 
 2.6/Documentation/sysctl/vm/percpu_pagelist_fraction                |   12 
 2.6/Documentation/sysctl/vm/swap_token_timeout                      |    4 
 2.6/Documentation/sysctl/vm/swappiness                              |    1 
 2.6/Documentation/sysctl/vm/vdso_enabled                            |    1 
 2.6/Documentation/sysctl/vm/vfs_cache_pressure                      |    8 
 2.6/Documentation/sysctl/vm/zone_reclaim_interval                   |    7 
 2.6/Documentation/sysctl/vm/zone_reclaim_mode                       |   38 
 Documentation/sysctl/fs.txt                                         |  150 -
 Documentation/sysctl/kernel.txt                                     |  344 --
 Documentation/sysctl/sunrpc.txt                                     |   20 
 Documentation/sysctl/vm.txt                                         |  180 -
 329 files changed, 1306 insertions(+), 2899 deletions(-)

Signed-off-by: Diego Calleja <diegocg@gmail.com>

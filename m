Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWFGVVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWFGVVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 17:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWFGVVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 17:21:55 -0400
Received: from igraine.blacknight.ie ([217.114.173.147]:47585 "EHLO
	igraine.blacknight.ie") by vger.kernel.org with ESMTP
	id S932423AbWFGVVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 17:21:52 -0400
Date: Wed, 7 Jun 2006 21:24:21 +0000
From: Robert Fitzsimons <robfitz@273k.net>
To: Diego Calleja <diegocg@gmail.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: [PATCH] Updated Documentation/networking/ip-sysctl.txt
Message-ID: <20060607212421.GA24235@localhost>
References: <20060607205316.bbb3c379.diegocg@gmail.com> <20060607124641.516c7fff@localhost.localdomain> <20060607225551.9b7e9688.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060607225551.9b7e9688.diegocg@gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (score=1.988, required 7.5, RCVD_IN_SORBS_DUL 1.99)
X-blacknight-igraine-MailScanner-SpamScore: s
X-MailScanner-From: robfitz@273k.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reformatted entries so they are now sorted alphabetical within a
/proc/sys/net/ sub-directory.
Synced with 2.6.17-rc6, added markers for new entries which are missing
a description or new descriptions which need to be checked.
Added some missing descriptions, also added descriptions suggested by
Stephen Hemminger <shemminger@osdl.org>.
Updated some existing descriptions.
Use consistant formatting and text wrapping, and updated default values
to match code.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---

Hello Diego

I was working on updating ip-sysctl.txt as a kernel-janitors project as
suggested by Stephen.

Here is my work so far.

Robert


 Documentation/networking/ip-sysctl.txt | 1565 +++++++++++++++++++-------------
 1 files changed, 907 insertions(+), 658 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.txt b/Documentation/networking/ip-sysctl.txt
index f12007b..94e6916 100644
--- a/Documentation/networking/ip-sysctl.txt
+++ b/Documentation/networking/ip-sysctl.txt
@@ -1,667 +1,822 @@
+/proc/sys/net/core/* Variables:
+
+dev_weight - INTEGER
+	TODO Add description.
+	Default: 64
+
+divert_version - STRING
+	TODO Check description.
+	String returned by DIVCMD_GETVERSION ioctl().
+	Default: 0.46
+
+message_burst - INTEGER
+	TODO Check description.
+	Allow a burst of message_burst network warning messages before the
+	rate limiting starts.  Also see message_cost.
+	Default: 10
+
+message_cost - INTEGER
+	TODO Check description.
+	Rate limit the number of network warning messages to one every
+	message_cost seconds.  Also see message_burst.
+	Default: 5
+
+netdev_budget - INTEGER
+	TODO Check description.
+	Maximum number of packets processed per device per softirq.  Used to
+	stop a device from overloading the system under massive packet load.
+	Default: 300
+
+netdev_max_backlog - INTEGER
+	TODO Check description.
+	Limit on the outstanding receive packets queued per cpu.  Applies to
+	non-NAPI devices only.
+	Default: 1000
+
+optmem_max - INTEGER
+	TODO Add description.
+
+rmem_default - INTEGER
+	TODO Add description.
+
+rmem_max - INTEGER
+	TODO Add description.
+
+somaxconn - INTEGER
+	Limit of socket listen() backlog, known in userspace as SOMAXCONN.
+	See also tcp_max_syn_backlog for additional tuning for TCP sockets.
+	Default: 128
+
+wmem_default - INTEGER
+	TODO Add description.
+
+wmem_max - INTEGER
+	TODO Add description.
+
+xfrm_aevent_etime - u32
+	TODO Add description.
+	Default: 10
+
+xfrm_aevent_rseqth - u32
+	TODO Add description.
+	Default: 2
+
+
 /proc/sys/net/ipv4/* Variables:
 
-ip_forward - BOOLEAN
-	0 - disabled (default)
-	not 0 - enabled 
+icmp_echo_ignore_all - BOOLEAN
+	If set non-zero, then the kernel will ignore all ICMP ECHO requests
+	sent to it.
+	Default: 0
 
-	Forward Packets between interfaces.
+icmp_echo_ignore_broadcasts - BOOLEAN
+	If set non-zero, then the kernel will ignore all ICMP ECHO and
+	TIMESTAMP requests sent to it via broadcast/multicast.
+	Default: 1
 
-	This variable is special, its change resets all configuration
-	parameters to their default state (RFC1122 for hosts, RFC1812
-	for routers)
+icmp_errors_use_inbound_ifaddr - BOOLEAN
+	If zero, ICMP error messages are sent with the primary address of
+	the exiting interface.
 
-ip_default_ttl - INTEGER
-	default 64
+	If non-zero, the message will be sent with the primary address of
+	the interface that received the packet that caused the ICMP error.
+	This is the behaviour network many administrators will expect from
+	a router.  And it can make debugging complicated network layouts
+	much easier.
 
-ip_no_pmtu_disc - BOOLEAN
-	Disable Path MTU Discovery.
-	default FALSE
+	Note that if no primary address exists for the interface selected,
+	then the primary address of the first non-loopback interface that
+	has one will be used regardless of this setting.
+	Default: 0
 
-min_pmtu - INTEGER
-	default 562 - minimum discovered Path MTU
+icmp_ignore_bogus_error_responses - BOOLEAN
+	Some routers violate RFC1122 by sending bogus responses to broadcast
+	frames.  Such violations are normally logged via a kernel warning.
+	If this is set to TRUE, the kernel will not give such warnings,
+	which will avoid log file clutter.
+	Default: 1
 
-mtu_expires - INTEGER
-	Time, in seconds, that cached PMTU information is kept.
+icmp_ratelimit - INTEGER
+	Limit the maximal rates for sending ICMP packets whose type matches
+	icmp_ratemask to specific targets.
+	0 to disable any limiting, otherwise the maximal rate in jiffies(1)
+	Default: jiffies in one second
 
-min_adv_mss - INTEGER
-	The advertised MSS depends on the first hop route MTU, but will
-	never be lower than this setting.
+icmp_ratemask - INTEGER
+	Mask made of ICMP types for which rates are being limited.
 
-IP Fragmentation:
+	Bit definitions (see include/linux/icmp.h):
+		0 Echo Reply
+		3 Destination Unreachable *
+		4 Source Quench *
+		5 Redirect
+		8 Echo Request
+		B Time Exceeded *
+		C Parameter Problem *
+		D Timestamp Request
+		E Timestamp Reply
+		F Info Request
+		G Info Reply
+		H Address Mask Request
+		I Address Mask Reply
+	* These are rate limited by default (see default mask above)
 
-ipfrag_high_thresh - INTEGER
-	Maximum memory used to reassemble IP fragments. When 
-	ipfrag_high_thresh bytes of memory is allocated for this purpose,
-	the fragment handler will toss packets until ipfrag_low_thresh
-	is reached.
-	
-ipfrag_low_thresh - INTEGER
-	See ipfrag_high_thresh	
+	Significant bits: IHGFEDCBA9876543210
+	Default mask:     0000001100000011000 (6168)
 
-ipfrag_time - INTEGER
-	Time in seconds to keep an IP fragment in memory.	
+igmp_max_memberships - INTEGER
+	Change the maximum number of multicast groups we can subscribe to.
+	Default: 20
 
-ipfrag_secret_interval - INTEGER
-	Regeneration interval (in seconds) of the hash secret (or lifetime 
-	for the hash secret) for IP fragments.
-	Default: 600
+igmp_max_msf - INTEGER
+	TODO Check description.
+	Limit on the number of multicast source filters.
+	Default: 10
 
-ipfrag_max_dist - INTEGER
-	ipfrag_max_dist is a non-negative integer value which defines the 
-	maximum "disorder" which is allowed among fragments which share a 
-	common IP source address. Note that reordering of packets is 
-	not unusual, but if a large number of fragments arrive from a source 
-	IP address while a particular fragment queue remains incomplete, it 
-	probably indicates that one or more fragments belonging to that queue 
-	have been lost. When ipfrag_max_dist is positive, an additional check 
-	is done on fragments before they are added to a reassembly queue - if 
-	ipfrag_max_dist (or more) fragments have arrived from a particular IP 
-	address between additions to any IP fragment queue using that source 
-	address, it's presumed that one or more fragments in the queue are 
-	lost. The existing fragment queue will be dropped, and a new one 
-	started. An ipfrag_max_dist value of zero disables this check.
+inet_peer_gc_maxtime - INTEGER
+	Maximum interval between garbage collection passes.  This interval
+	is in effect under low (or absent) memory pressure on the pool.
+	Default: 120 sec
 
-	Using a very small value, e.g. 1 or 2, for ipfrag_max_dist can
-	result in unnecessarily dropping fragment queues when normal
-	reordering of packets occurs, which could lead to poor application 
-	performance. Using a very large value, e.g. 50000, increases the 
-	likelihood of incorrectly reassembling IP fragments that originate 
-	from different IP datagrams, which could result in data corruption.
-	Default: 64
+inet_peer_gc_mintime - INTEGER
+	Minimum interval between garbage collection passes.  This interval
+	is in effect under high memory pressure on the pool.
+	Default: 10 sec
 
-INET peer storage:
+inet_peer_maxttl - INTEGER
+	Maximum time-to-live of entries.  Unused entries will expire after
+	this period of time if there is no memory pressure on the pool (i.e.
+	when the number of entries in the pool is very small).
+	Default: 600 sec
+
+inet_peer_minttl - INTEGER
+	Minimum time-to-live of entries.  Should be enough to cover fragment
+	time-to-live on the reassembling side.  This minimum time-to-live is
+	guaranteed if the pool size is less than inet_peer_threshold.
+	Default: 120 sec
 
 inet_peer_threshold - INTEGER
-	The approximate size of the storage.  Starting from this threshold	
+	The approximate size of the storage.  Starting from this threshold
 	entries will be thrown aggressively.  This threshold also determines
 	entries' time-to-live and time intervals between garbage collection
 	passes.  More entries, less time-to-live, less GC interval.
+	Default: dependent on system memory
 
-inet_peer_minttl - INTEGER
-	Minimum time-to-live of entries.  Should be enough to cover fragment
-	time-to-live on the reassembling side.  This minimum time-to-live  is
-	guaranteed if the pool size is less than inet_peer_threshold.
-	Measured in jiffies(1).
+ip_autoconfig - ????
+	TODO Add description.
 
-inet_peer_maxttl - INTEGER
-	Maximum time-to-live of entries.  Unused entries will expire after
-	this period of time if there is no memory pressure on the pool (i.e.
-	when the number of entries in the pool is very small).
-	Measured in jiffies(1).
+ip_default_ttl - INTEGER
+	Default: 64
 
-inet_peer_gc_mintime - INTEGER
-	Minimum interval between garbage collection passes.  This interval is
-	in effect under high memory pressure on the pool.
-	Measured in jiffies(1).
+ip_dynaddr - BOOLEAN
+	If non-zero, enables support for dynamic addresses.  If set to a
+	non-zero value larger than 1, a kernel log message will be printed
+	when dynamic address rewriting occurs.
+	Default: 0
 
-inet_peer_gc_maxtime - INTEGER
-	Minimum interval between garbage collection passes.  This interval is
-	in effect under low (or absent) memory pressure on the pool.
-	Measured in jiffies(1).
+ip_forward - BOOLEAN
+	If non-zero, forward packets between interfaces.  This variable is
+	special, its change resets all configuration parameters to their
+	default state (RFC1122 for hosts, RFC1812 for routers).
+	Default: 0
 
-TCP variables: 
+ipfrag_high_thresh - INTEGER
+	Maximum memory used to reassemble IP fragments.  When
+	ipfrag_high_thresh bytes of memory is allocated for this purpose,
+	the fragment handler will toss packets until ipfrag_low_thresh is
+	reached.
+	Default: 256k
+
+ipfrag_low_thresh - INTEGER
+	See ipfrag_high_thresh.
+	Default: 192k
+
+ipfrag_max_dist - INTEGER
+	ipfrag_max_dist is a non-negative integer value which defines the
+	maximum "disorder" which is allowed among fragments which share a
+	common IP source address.  Note that reordering of packets is not
+	unusual, but if a large number of fragments arrive from a source IP
+	address while a particular fragment queue remains incomplete, it
+	probably indicates that one or more fragments belonging to that
+	queue have been lost.
+	
+	When ipfrag_max_dist is positive, an additional check is done on
+	fragments before they are added to a reassembly queue - if
+	ipfrag_max_dist (or more) fragments have arrived from a particular
+	IP address between additions to any IP fragment queue using that
+	source address, it's presumed that one or more fragments in the
+	queue are lost.  The existing fragment queue will be dropped, and a
+	new one started.  An ipfrag_max_dist value of zero disables this
+	check.
+
+	Using a very small value, e.g. 1 or 2, for ipfrag_max_dist can
+	result in unnecessarily dropping fragment queues when normal
+	reordering of packets occurs, which could lead to poor application
+	performance.  Using a very large value, e.g. 50000, increases the
+	likelihood of incorrectly reassembling IP fragments that originate
+	from different IP datagrams, which could result in data corruption.
+	Default: 64
+
+ipfrag_secret_interval - INTEGER
+	Regeneration interval (in seconds) of the hash secret (or lifetime
+	for the hash secret) for IP fragments.
+	Default: 600
+
+ipfrag_time - INTEGER
+	Time in seconds to keep an IP fragment in memory.
+	Default: 30
+
+ip_local_port_range - 2 INTEGERS
+	Defines the local port range that is used by TCP and UDP to choose
+	the local port.  The first number is the first, the second the last
+	local port number.
+
+	This number defines number of active connections, which this system
+	can issue simultaneously to systems not supporting TCP extensions
+	(timestamps).  With tcp_tw_recycle enabled (i.e. by default) range
+	1024-4999 is enough to issue up to 2000 connections per second to
+	systems supporting timestamps.
+	Default: dependent on system memory
+	> 128Mb 32768-61000
+	< 128Mb 1024-4999 or even less.
+
+ip_nonlocal_bind - BOOLEAN
+	If set, allows processes to bind() to non-local IP addresses, which
+	can be quite useful - but may break some applications.
+	Default: 0
+
+ip_no_pmtu_disc - BOOLEAN
+	Disable Path MTU Discovery.
+	Default: 0
 
 tcp_abc - INTEGER
-	Controls Appropriate Byte Count defined in RFC3465. If set to
-	0 then does congestion avoid once per ack. 1 is conservative
-	value, and 2 is more agressive.
+	Controls Appropriate Byte Count defined in RFC3465.  If set to 0
+	then does congestion avoid once per ACK.  1 is conservative value,
+	and 2 is more aggressive.
+	Default: 1
 
-tcp_syn_retries - INTEGER
-	Number of times initial SYNs for an active TCP connection attempt
-	will be retransmitted. Should not be higher than 255. Default value
-	is 5, which corresponds to ~180seconds.
+tcp_abort_on_overflow - BOOLEAN
+	If listening service is too slow to accept new connections, reset
+	them.  It means that if overflow occurred due to a burst, connection
+	will recover.  Enable this option _only_ if you are really sure that
+	listening daemon cannot be tuned to accept connections faster.
+	Enabling this option can harm clients of your server.
+	Default: 0
 
-tcp_synack_retries - INTEGER
-	Number of times SYNACKs for a passive TCP connection attempt will
-	be retransmitted. Should not be higher than 255. Default value
-	is 5, which corresponds to ~180seconds.
+tcp_adv_win_scale - INTEGER
+	Count buffering overhead as bytes/2^tcp_adv_win_scale
+	(if tcp_adv_win_scale > 0) or bytes-bytes/2^(-tcp_adv_win_scale),
+	if it is <= 0.
+	Default: 2
 
-tcp_keepalive_time - INTEGER
-	How often TCP sends out keepalive messages when keepalive is enabled.
-	Default: 2hours.
+tcp_app_win - INTEGER
+	Reserve max(window/2^tcp_app_win, mss) of window for application
+	buffer.  Value 0 is special, it means that nothing is reserved.
+	Default: 31
 
-tcp_keepalive_probes - INTEGER
-	How many keepalive probes TCP sends out, until it decides that the
-	connection is broken. Default value: 9.
+tcp_base_mss - INTEGER
+	TODO Check description.
+	Lower bound for TCP path MTU discovery probing.
+	Default: 512
 
-tcp_keepalive_intvl - INTEGER
-	How frequently the probes are send out. Multiplied by
-	tcp_keepalive_probes it is time to kill not responding connection,
-	after probes started. Default value: 75sec i.e. connection
-	will be aborted after ~11 minutes of retries.
+tcp_congestion_control - STRING
+	Set the congestion control algorithm to be used for new connections.
+	The algorithm "reno" is always available, but additional choices may
+	be available based on kernel configuration.
 
-tcp_retries1 - INTEGER
-	How many times to retry before deciding that something is wrong
-	and it is necessary to report this suspicion to network layer.
-	Minimal RFC value is 3, it is default, which corresponds
-	to ~3sec-8min depending on RTO.
+tcp_dsack - BOOLEAN
+	Allows TCP to send "duplicate" SACKs.
+	Default: 1
 
-tcp_retries2 - INTEGER
-	How may times to retry before killing alive TCP connection.
-	RFC1122 says that the limit should be longer than 100 sec.
-	It is too small number.	Default value 15 corresponds to ~13-30min
-	depending on RTO.
+tcp_ecn - BOOLEAN
+	Enable Explicit Congestion Notification in TCP.
+	Default: 0
 
-tcp_orphan_retries - INTEGER
-	How may times to retry before killing TCP connection, closed
-	by our side. Default value 7 corresponds to ~50sec-16min
-	depending on RTO. If you machine is loaded WEB server,
-	you should think about lowering this value, such sockets
-	may consume significant resources. Cf. tcp_max_orphans.
+tcp_fack - BOOLEAN
+	Enable FACK congestion avoidance and fast retransmission.  The value
+	is not used, if tcp_sack is not enabled.
+	Default: 1
 
 tcp_fin_timeout - INTEGER
-	Time to hold socket in state FIN-WAIT-2, if it was closed
-	by our side. Peer can be broken and never close its side,
-	or even died unexpectedly. Default value is 60sec.
-	Usual value used in 2.2 was 180 seconds, you may restore
-	it, but remember that if your machine is even underloaded WEB server,
-	you risk to overflow memory with kilotons of dead sockets,
-	FIN-WAIT-2 sockets are less dangerous than FIN-WAIT-1,
-	because they eat maximum 1.5K of memory, but they tend
-	to live longer.	Cf. tcp_max_orphans.
+	Time in seconds to hold socket in state FIN-WAIT-2, if it was closed
+	by our side.  Peer can be broken and never close its side, or even
+	died unexpectedly.
+
+	Usual value used in 2.2 was 180 seconds, you may restore it, but
+	remember that if your machine is even underloaded WEB server, you
+	risk to overflow memory with kilotons of dead sockets, FIN-WAIT-2
+	sockets are less dangerous than FIN-WAIT-1, because they eat maximum
+	1.5K of memory, but they tend to live longer.  See tcp_max_orphans.
+	Default: 60
 
-tcp_max_tw_buckets - INTEGER
-	Maximal number of timewait sockets held by system simultaneously.
-	If this number is exceeded time-wait socket is immediately destroyed
-	and warning is printed. This limit exists only to prevent
-	simple DoS attacks, you _must_ not lower the limit artificially,
-	but rather increase it (probably, after increasing installed memory),
-	if network conditions require more than default value.
+tcp_frto - BOOLEAN
+	Enables F-RTO, an enhanced recovery algorithm for TCP retransmission
+	timeouts.  It is particularly beneficial in wireless environments
+	where packet loss is typically due to random radio interference
+	rather than intermediate router congestion.
+	Default: 0
 
-tcp_tw_recycle - BOOLEAN
-	Enable fast recycling TIME-WAIT sockets. Default value is 0.
-	It should not be changed without advice/request of technical
-	experts.
+tcp_keepalive_intvl - INTEGER
+	How frequently the probes are send out.  Multiplied by
+	tcp_keepalive_probes it is time to kill not responding connection,
+	after probes started.
+	Default: 75 secs
 
-tcp_tw_reuse - BOOLEAN
-	Allow to reuse TIME-WAIT sockets for new connections when it is
-	safe from protocol viewpoint. Default value is 0.
-	It should not be changed without advice/request of technical
-	experts.
+tcp_keepalive_probes - INTEGER
+	How many keepalive probes TCP sends out, until it decides that the
+	connection is broken.
+	Default: 9
+
+tcp_keepalive_time - INTEGER
+	How often TCP sends out keepalive messages when keepalive is
+	enabled.
+	Default: 2 hours
+
+tcp_low_latency - BOOLEAN
+	If set, the TCP stack makes decisions that prefer lower latency as
+	opposed to higher throughput.  By default, this option is not set
+	meaning that higher throughput is preferred.  An example of an
+	application where this default should be changed would be a Beowulf
+	compute cluster.
+	Default: 0
 
 tcp_max_orphans - INTEGER
 	Maximal number of TCP sockets not attached to any user file handle,
-	held by system.	If this number is exceeded orphaned connections are
-	reset immediately and warning is printed. This limit exists
-	only to prevent simple DoS attacks, you _must_ not rely on this
-	or lower the limit artificially, but rather increase it
-	(probably, after increasing installed memory),
-	if network conditions require more than default value,
-	and tune network services to linger and kill such states
-	more aggressively. Let me to remind again: each orphan eats
-	up to ~64K of unswappable memory.
+	held by system.  If this number is exceeded orphaned connections are
+	reset immediately and warning is printed.  This limit exists only to
+	prevent simple DoS attacks, you _must_ not rely on this or lower the
+	limit artificially, but rather increase it (probably, after
+	increasing installed memory), if network conditions require more
+	than default value, and tune network services to linger and kill
+	such states more aggressively.  Let me to remind again: each orphan
+	eats up to ~64K of unswappable memory.
 
-tcp_abort_on_overflow - BOOLEAN
-	If listening service is too slow to accept new connections,
-	reset them. Default state is FALSE. It means that if overflow
-	occurred due to a burst, connection will recover. Enable this
-	option _only_ if you are really sure that listening daemon
-	cannot be tuned to accept connections faster. Enabling this
-	option can harm clients of your server.
+tcp_max_syn_backlog - INTEGER
+	Maximal number of remembered connection requests, which are still
+	did not receive an acknowledgment from connecting client.  If server
+	suffers of overload, try to increase this number.
+	Default: dependent on system memory
+	> 128Mb 1024
+	< 128Mb 128
 
-tcp_syncookies - BOOLEAN
-	Only valid when the kernel was compiled with CONFIG_SYNCOOKIES
-	Send out syncookies when the syn backlog queue of a socket 
-	overflows. This is to prevent against the common 'syn flood attack'
-	Default: FALSE
+tcp_max_tw_buckets - INTEGER
+	Maximal number of time-wait sockets held by system simultaneously.
+	If this number is exceeded time-wait socket is immediately destroyed
+	and warning is printed.  This limit exists only to prevent simple
+	DoS attacks, you _must_ not lower the limit artificially, but rather
+	increase it (probably, after increasing installed memory), if
+	network conditions require more than default value.
 
-	Note, that syncookies is fallback facility.
-	It MUST NOT be used to help highly loaded servers to stand
-	against legal connection rate. If you see synflood warnings
-	in your logs, but investigation	shows that they occur
-	because of overload with legal connections, you should tune
-	another parameters until this warning disappear.
-	See: tcp_max_syn_backlog, tcp_synack_retries, tcp_abort_on_overflow.
-
-	syncookies seriously violate TCP protocol, do not allow
-	to use TCP extensions, can result in serious degradation
-	of some services (f.e. SMTP relaying), visible not by you,
-	but your clients and relays, contacting you. While you see
-	synflood warnings in logs not being really flooded, your server
-	is seriously misconfigured.
+tcp_mem - vector of 3 INTEGERs: low, pressure, max
+	low: Below this number of pages TCP is not bothered about its memory
+	appetite.
 
-tcp_stdurg - BOOLEAN
-	Use the Host requirements interpretation of the TCP urg pointer field.
-	Most hosts use the older BSD interpretation, so if you turn this on
-	Linux might not communicate correctly with them.	
-	Default: FALSE 
-	
-tcp_max_syn_backlog - INTEGER
-	Maximal number of remembered connection requests, which are
-	still did not receive an acknowledgment from connecting client.
-	Default value is 1024 for systems with more than 128Mb of memory,
-	and 128 for low memory machines. If server suffers of overload,
-	try to increase this number.
+	pressure: When amount of memory allocated by TCP exceeds this number
+	of pages, TCP moderates its memory consumption and enters memory
+	pressure mode, which is exited when memory consumption falls under
+	"low".
 
-tcp_window_scaling - BOOLEAN
-	Enable window scaling as defined in RFC1323.
+	max: Number of pages allowed for queueing by all TCP sockets.
 
-tcp_timestamps - BOOLEAN
-	Enable timestamps as defined in RFC1323.
+	See tcp_rmem, tcp_wmem.
+	Default: dependent on system memory
 
-tcp_sack - BOOLEAN
-	Enable select acknowledgments (SACKS).
+tcp_moderate_rcvbuf - BOOLEAN
+	TODO Check description.
+	If set TCP automatically adjusts the size of the socket receive
+	window based on the amount of space used in the receive queue.
+	Default: 1
 
-tcp_fack - BOOLEAN
-	Enable FACK congestion avoidance and fast retransmission.
-	The value is not used, if tcp_sack is not enabled.
+tcp_mtu_probing - INTEGER
+	TODO Check description.
+	If non-zero, then TCP attempts to discover routers that do not
+	correctly return ICMP fragmentation needed when receiving oversize
+	packets "black-holes".  If the value is greater than one, don't use
+	the cached pmtu value before attempting to probe.
+	Default: 0
 
-tcp_dsack - BOOLEAN
-	Allows TCP to send "duplicate" SACKs.
+tcp_no_metrics_save - BOOLEAN
+	TODO Check description.
+	Normally, TCP will remember some characteristics about the last
+	connection in the flow cache.  If tcp_no_metrics_save is set, then
+	it doesn't.  Useful for benchmarks or other tests.
+	Default: 0
 
-tcp_ecn - BOOLEAN
-	Enable Explicit Congestion Notification in TCP.
+tcp_orphan_retries - INTEGER
+	How may times to retry before killing TCP connection, closed by our
+	side.  If you machine is a loaded WEB server, you should think about
+	lowering this value, such sockets may consume significant resources.
+	See tcp_max_orphans.
+	Default: 0
 
 tcp_reordering - INTEGER
 	Maximal reordering of packets in a TCP stream.
-	Default: 3	
+	Default: 3
 
 tcp_retrans_collapse - BOOLEAN
-	Bug-to-bug compatibility with some broken printers.
-	On retransmit try to send bigger packets to work around bugs in
-	certain TCP stacks.
+	Bug-to-bug compatibility with some broken printers.  On retransmit
+	try to send bigger packets to work around bugs in certain TCP
+	stacks.
+	Default: 1
 
-tcp_wmem - vector of 3 INTEGERs: min, default, max
-	min: Amount of memory reserved for send buffers for TCP socket.
-	Each TCP socket has rights to use it due to fact of its birth.
-	Default: 4K
+tcp_retries1 - INTEGER
+	How many times to retry before deciding that something is wrong and
+	it is necessary to report this suspicion to network layer.  Minimal
+	RFC value is 3.
+	Default: 3
 
-	default: Amount of memory allowed for send buffers for TCP socket
-	by default. This value overrides net.core.wmem_default used
-	by other protocols, it is usually lower than net.core.wmem_default.
-	Default: 16K
+tcp_retries2 - INTEGER
+	How may times to retry before killing alive TCP connection.  RFC1122
+	says that the limit should be longer than 100 sec.  It is too small
+	number.
+	Default: 15
 
-	max: Maximal amount of memory allowed for automatically selected
-	send buffers for TCP socket. This value does not override
-	net.core.wmem_max, "static" selection via SO_SNDBUF does not use this.
-	Default: 128K
+tcp_rfc1337 - BOOLEAN
+	If set, the TCP stack behaves conforming to RFC1337.  If unset, we
+	are not conforming to RFC, but prevent TCP TIME_WAIT assassination.
+	Default: 0
 
 tcp_rmem - vector of 3 INTEGERs: min, default, max
-	min: Minimal size of receive buffer used by TCP sockets.
-	It is guaranteed to each TCP socket, even under moderate memory
-	pressure.
-	Default: 8K
-
-	default: default size of receive buffer used by TCP sockets.
-	This value overrides net.core.rmem_default used by other protocols.
-	Default: 87380 bytes. This value results in window of 65535 with
+	min: Minimal size of receive buffer used by TCP sockets.  It is
+	guaranteed to each TCP socket, even under moderate memory pressure.
+
+	default: Default size of receive buffer used by TCP sockets.  This
+	value overrides net.core.rmem_default used by other protocols.  The
+	default value of 87380 bytes, results in window of 65535 with
 	default setting of tcp_adv_win_scale and tcp_app_win:0 and a bit
-	less for default tcp_app_win. See below about these variables.
+	less for default tcp_app_win.
 
-	max: maximal size of receive buffer allowed for automatically
-	selected receiver buffers for TCP socket. This value does not override
-	net.core.rmem_max, "static" selection via SO_RCVBUF does not use this.
-	Default: 87380*2 bytes.
+	max: Maximal size of receive buffer allowed for automatically
+	selected receiver buffers for TCP socket.  This value does not
+	override net.core.rmem_max, "static" selection via SO_RCVBUF does
+	not use this.
+	See tcp_mem, tcp_wmem.
+	Default: 1 page, 16k, dependent on tcp_mem default
 
-tcp_mem - vector of 3 INTEGERs: min, pressure, max
-	low: below this number of pages TCP is not bothered about its
-	memory appetite.
+tcp_sack - BOOLEAN
+	Enable select acknowledgments (SACKS).
+	Default: 1
 
-	pressure: when amount of memory allocated by TCP exceeds this number
-	of pages, TCP moderates its memory consumption and enters memory
-	pressure mode, which is exited when memory consumption falls
-	under "low".
+tcp_stdurg - BOOLEAN
+	Use the Host requirements interpretation of the TCP urg pointer
+	field.  Most hosts use the older BSD interpretation, so if you turn
+	this on Linux might not communicate correctly with them.
+	Default: 0
 
-	high: number of pages allowed for queueing by all TCP sockets.
+tcp_synack_retries - INTEGER
+	Number of times SYNACKs for a passive TCP connection attempt will be
+	retransmitted.  Should not be higher than 255.  
+	Default: 5
 
-	Defaults are calculated at boot time from amount of available
-	memory.
+tcp_syncookies - BOOLEAN
+	Only valid when the kernel was compiled with CONFIG_SYNCOOKIES Send
+	out syncookies when the syn backlog queue of a socket overflows.
+	This is to prevent against the common 'syn flood attack'
 
-tcp_app_win - INTEGER
-	Reserve max(window/2^tcp_app_win, mss) of window for application
-	buffer. Value 0 is special, it means that nothing is reserved.
-	Default: 31
+	Note, that syncookies is fallback facility.
+	It MUST NOT be used to help highly loaded servers to stand against
+	legal connection rate.  If you see synflood warnings in your logs,
+	but investigation shows that they occur because of overload with
+	legal connections, you should tune another parameters until this
+	warning disappear.  See tcp_max_syn_backlog, tcp_synack_retries,
+	tcp_abort_on_overflow.
+
+	syncookies seriously violate TCP protocol, do not allow to use TCP
+	extensions, can result in serious degradation of some services (f.e.
+	SMTP relaying), visible not by you, but your clients and relays,
+	contacting you.  While you see synflood warnings in logs not being
+	really flooded, your server is seriously misconfigured.
+	Default: 0
 
-tcp_adv_win_scale - INTEGER
-	Count buffering overhead as bytes/2^tcp_adv_win_scale
-	(if tcp_adv_win_scale > 0) or bytes-bytes/2^(-tcp_adv_win_scale),
-	if it is <= 0.
-	Default: 2
+tcp_syn_retries - INTEGER
+	Number of times initial SYNs for an active TCP connection attempt
+	will be retransmitted.  Should not be higher than 255.
+	Default: 5
 
-tcp_rfc1337 - BOOLEAN
-	If set, the TCP stack behaves conforming to RFC1337. If unset,
-	we are not conforming to RFC, but prevent TCP TIME_WAIT
-	assassination.   
+tcp_timestamps - BOOLEAN
+	Enable timestamps as defined in RFC1323.
+	Default: 1
+
+tcp_tso_win_divisor - INTEGER
+	This allows control over what percentage of the congestion window
+	can be consumed by a single TSO frame.  The setting of this
+	parameter is a choice between burstiness and building larger TSO
+	frames.
+	Default: 3
+
+tcp_tw_recycle - BOOLEAN
+	Enable fast recycling TIME-WAIT sockets.  The default value should
+	not be changed without advice/request of technical experts.
 	Default: 0
 
-tcp_low_latency - BOOLEAN
-	If set, the TCP stack makes decisions that prefer lower
-	latency as opposed to higher throughput.  By default, this
-	option is not set meaning that higher throughput is preferred.
-	An example of an application where this default should be
-	changed would be a Beowulf compute cluster.
+tcp_tw_reuse - BOOLEAN
+	Allow to reuse TIME-WAIT sockets for new connections when it is safe
+	from protocol viewpoint.  The default value should not be changed
+	without advice/request of technical experts.
 	Default: 0
 
-tcp_tso_win_divisor - INTEGER
-       This allows control over what percentage of the congestion window
-       can be consumed by a single TSO frame.
-       The setting of this parameter is a choice between burstiness and
-       building larger TSO frames.
-       Default: 3
+tcp_window_scaling - BOOLEAN
+	Enable window scaling as defined in RFC1323.
+	Default: 1
 
-tcp_frto - BOOLEAN
-	Enables F-RTO, an enhanced recovery algorithm for TCP retransmission
-	timeouts.  It is particularly beneficial in wireless environments
-	where packet loss is typically due to random radio interference
-	rather than intermediate router congestion.
+tcp_wmem - vector of 3 INTEGERs: min, default, max
+	min: Amount of memory reserved for send buffers for TCP socket.
+	Each TCP socket has rights to use it due to fact of its birth.
 
-tcp_congestion_control - STRING
-	Set the congestion control algorithm to be used for new
-	connections. The algorithm "reno" is always available, but
-	additional choices may be available based on kernel configuration.
+	default: Amount of memory allowed for send buffers for TCP socket by
+	default.  This value overrides net.core.wmem_default used by other
+	protocols, it is usually lower than net.core.wmem_default.
 
-somaxconn - INTEGER
-	Limit of socket listen() backlog, known in userspace as SOMAXCONN.
-	Defaults to 128.  See also tcp_max_syn_backlog for additional tuning
-	for TCP sockets.
+	max: Maximal amount of memory allowed for automatically selected
+	send buffers for TCP socket.  This value does not override
+	net.core.wmem_max, "static" selection via SO_SNDBUF does not use
+	this.
+	See tcp_mem, tcp_rmem.
+	Default: 1 page, 16k, dependent on tcp_mem default
 
 tcp_workaround_signed_windows - BOOLEAN
 	If set, assume no receipt of a window scaling option means the
-	remote TCP is broken and treats the window as a signed quantity.
-	If unset, assume the remote TCP is not broken even if we do
-	not receive a window scaling option from them.
+	remote TCP is broken and treats the window as a signed quantity.  If
+	unset, assume the remote TCP is not broken even if we do not receive
+	a window scaling option from them.
 	Default: 0
 
-IP Variables:
 
-ip_local_port_range - 2 INTEGERS
-	Defines the local port range that is used by TCP and UDP to
-	choose the local port. The first number is the first, the 
-	second the last local port number. Default value depends on
-	amount of memory available on the system:
-	> 128Mb 32768-61000
-	< 128Mb 1024-4999 or even less.
-	This number defines number of active connections, which this
-	system can issue simultaneously to systems not supporting
-	TCP extensions (timestamps). With tcp_tw_recycle enabled
-	(i.e. by default) range 1024-4999 is enough to issue up to
-	2000 connections per second to systems supporting timestamps.
-
-ip_nonlocal_bind - BOOLEAN
-	If set, allows processes to bind() to non-local IP addresses,
-	which can be quite useful - but may break some applications.
-	Default: 0
+/proc/sys/net/ipv4/route/* Variables:
 
-ip_dynaddr - BOOLEAN
-	If set non-zero, enables support for dynamic addresses.
-	If set to a non-zero value larger than 1, a kernel log
-	message will be printed when dynamic address rewriting
-	occurs.
-	Default: 0
-
-icmp_echo_ignore_all - BOOLEAN
-	If set non-zero, then the kernel will ignore all ICMP ECHO
-	requests sent to it.
-	Default: 0
+error_burst - INTEGER
+	TODO Add description.
+	Default: 5
 
-icmp_echo_ignore_broadcasts - BOOLEAN
-	If set non-zero, then the kernel will ignore all ICMP ECHO and
-	TIMESTAMP requests sent to it via broadcast/multicast.
+error_cost - INTEGER
+	TODO Add description.
 	Default: 1
 
-icmp_ratelimit - INTEGER
-	Limit the maximal rates for sending ICMP packets whose type matches
-	icmp_ratemask (see below) to specific targets.
-	0 to disable any limiting, otherwise the maximal rate in jiffies(1)
-	Default: 100
-
-icmp_ratemask - INTEGER
-	Mask made of ICMP types for which rates are being limited.
-	Significant bits: IHGFEDCBA9876543210
-	Default mask:     0000001100000011000 (6168)
-
-	Bit definitions (see include/linux/icmp.h):
-		0 Echo Reply
-		3 Destination Unreachable *
-		4 Source Quench *
-		5 Redirect
-		8 Echo Request
-		B Time Exceeded *
-		C Parameter Problem *
-		D Timestamp Request
-		E Timestamp Reply
-		F Info Request
-		G Info Reply
-		H Address Mask Request
-		I Address Mask Reply
+flush - INTEGER
+	TODO Add description.
+	Default: 0
 
-	* These are rate limited by default (see default mask above)
+gc_elasticity - INTEGER
+	TODO Add description.
+	Default: 8
 
-icmp_ignore_bogus_error_responses - BOOLEAN
-	Some routers violate RFC1122 by sending bogus responses to broadcast
-	frames.  Such violations are normally logged via a kernel warning.
-	If this is set to TRUE, the kernel will not give such warnings, which
-	will avoid log file clutter.
-	Default: FALSE
+gc_interval - INTEGER
+	TODO Add description.
+	Default: 60
 
-icmp_errors_use_inbound_ifaddr - BOOLEAN
+gc_min_interval - INTEGER
+	TODO Check description.
+	Deprecated.  Use gc_min_interval_ms.
 
-	If zero, icmp error messages are sent with the primary address of
-	the exiting interface.
- 
-	If non-zero, the message will be sent with the primary address of
-	the interface that received the packet that caused the icmp error.
-	This is the behaviour network many administrators will expect from
-	a router. And it can make debugging complicated network layouts
-	much easier. 
+gc_min_interval_ms - INTEGER
+	TODO Add description.
+	Default: 500
 
-	Note that if no primary address exists for the interface selected,
-	then the primary address of the first non-loopback interface that
-	has one will be used regarldess of this setting.
+gc_thresh - INTEGER
+	TODO Add description.
 
-	Default: 0
+gc_timeout - INTEGER
+	TODO Add description.
+	Default: 300
 
-igmp_max_memberships - INTEGER
-	Change the maximum number of multicast groups we can subscribe to.
-	Default: 20
+max_delay - INTEGER
+	TODO Add description.
+	Default: 10
 
-conf/interface/*  changes special settings per interface (where "interface" is 
-		  the name of your network interface)
-conf/all/*	  is special, changes the settings for all interfaces
+max_size - INTEGER
+	TODO Add description.
 
+min_adv_mss - INTEGER
+	The advertised MSS depends on the first hop route MTU, but will
+	never be lower than this setting.
+	Default: 256
 
-log_martians - BOOLEAN
-	Log packets with impossible addresses to kernel log.
-	log_martians for the interface will be enabled if at least one of
-	conf/{all,interface}/log_martians is set to TRUE,
-	it will be disabled otherwise
+min_delay - INTEGER
+	TODO Add description.
+	Default: 2
 
-accept_redirects - BOOLEAN
-	Accept ICMP redirect messages.
-	accept_redirects for the interface will be enabled if:
-	- both conf/{all,interface}/accept_redirects are TRUE in the case forwarding
-	  for the interface is enabled
-	or
-	- at least one of conf/{all,interface}/accept_redirects is TRUE in the case
-	  forwarding for the interface is disabled
-	accept_redirects for the interface will be disabled otherwise
-	default TRUE (host)
-		FALSE (router)
+min_pmtu - INTEGER
+	Minimum discovered Path MTU
+	Default: 552
 
-forwarding - BOOLEAN
-	Enable IP forwarding on this interface.
+mtu_expires - INTEGER
+	Time, in seconds, that cached PMTU information is kept.
+	Default: 600
 
-mc_forwarding - BOOLEAN
-	Do multicast routing. The kernel needs to be compiled with CONFIG_MROUTE
-	and a multicast routing daemon is required.
-	conf/all/mc_forwarding must also be set to TRUE to enable multicast routing
-	for the interface
+redirect_load - INTEGER
+	TODO Add description.
+	Default: 5
 
-medium_id - INTEGER
-	Integer value used to differentiate the devices by the medium they
-	are attached to. Two devices can have different id values when
-	the broadcast packets are received only on one of them.
-	The default value 0 means that the device is the only interface
-	to its medium, value of -1 means that medium is not known.
-	
-	Currently, it is used to change the proxy_arp behavior:
-	the proxy_arp feature is enabled for packets forwarded between
-	two devices attached to different media.
+redirect_number - INTEGER
+	TODO Add description.
+	Default: 9
 
-proxy_arp - BOOLEAN
-	Do proxy arp.
-	proxy_arp for the interface will be enabled if at least one of
-	conf/{all,interface}/proxy_arp is set to TRUE,
-	it will be disabled otherwise
+redirect_silence - INTEGER
+	TODO Add description.
 
-shared_media - BOOLEAN
-	Send(router) or accept(host) RFC1620 shared media redirects.
-	Overrides ip_secure_redirects.
-	shared_media for the interface will be enabled if at least one of
-	conf/{all,interface}/shared_media is set to TRUE,
-	it will be disabled otherwise
-	default TRUE
+secret_interval - INTEGER
+	TODO Add description.
+	Default: 600
 
-secure_redirects - BOOLEAN
-	Accept ICMP redirect messages only for gateways,
-	listed in default gateway list.
-	secure_redirects for the interface will be enabled if at least one of
-	conf/{all,interface}/secure_redirects is set to TRUE,
-	it will be disabled otherwise
-	default TRUE
 
-send_redirects - BOOLEAN
-	Send redirects, if router.
-	send_redirects for the interface will be enabled if at least one of
-	conf/{all,interface}/send_redirects is set to TRUE,
-	it will be disabled otherwise
-	Default: TRUE
+/proc/sys/net/ipv4/conf/*/*
+/proc/sys/net/ipv4/conf/all/*
+/proc/sys/net/ipv4/conf/default/*
 
-bootp_relay - BOOLEAN
-	Accept packets with source address 0.b.c.d destined
-	not to this host as local ones. It is supposed, that
-	BOOTP relay daemon will catch and forward such packets.
-	conf/all/bootp_relay must also be set to TRUE to enable BOOTP relay
-	for the interface
-	default FALSE
-	Not Implemented Yet.
+accept_redirects - BOOLEAN
+	Accept ICMP redirect messages.
+	accept_redirects for the interface will be enabled if:
+	- both conf/{all,interface}/accept_redirects are TRUE in the case
+	  forwarding for the interface is enabled
+	or
+	- at least one of conf/{all,interface}/accept_redirects is TRUE in
+	  the case forwarding for the interface is disabled
+	accept_redirects for the interface will be disabled otherwise value
+	1 (host) and 0 (router).
+	Default: 1
 
 accept_source_route - BOOLEAN
-	Accept packets with SRR option.
-	conf/all/accept_source_route must also be set to TRUE to accept packets
-	with SRR option on the interface
-	default TRUE (router)
-		FALSE (host)
+	Accept packets with SRR option.  conf/all/accept_source_route must
+	also be set to 1 to accept packets with SRR option on the interface
+	value 1 (router) and 0 (host).
+	Default: 1
 
-rp_filter - BOOLEAN
-	1 - do source validation by reversed path, as specified in RFC1812
-	    Recommended option for single homed hosts and stub network
-	    routers. Could cause troubles for complicated (not loop free)
-	    networks running a slow unreliable protocol (sort of RIP),
-	    or using static routes.
+arp_accept - BOOLEAN
+	Define behavior when gratuitous ARP replies are received:
+	0 - drop gratuitous ARP frames
+	1 - accept gratuitous ARP frames
+	Default: 0
 
-	0 - No source validation.
+arp_announce - INTEGER
+	Define different restriction levels for announcing the local source
+	IP address from IP packets in ARP requests sent on interface:
+	0 - Use any local address, configured on any interface.
+	1 - Try to avoid local addresses that are not in the target's subnet
+	    for this interface.  This mode is useful when target hosts
+	    reachable via this interface require the source IP address in
+	    ARP requests to be part of their logical network configured on
+	    the receiving interface.  When we generate the request we will
+	    check all our subnets that include the target IP and will
+	    preserve the source address if it is from such subnet.  If there
+	    is no such subnet we select source address according to the
+	    rules for level 2.
+	2 - Always use the best local address for this target.  In this mode
+	    we ignore the source address in the IP packet and try to select
+	    local address that we prefer for talks with the target host.
+	    Such local address is selected by looking for primary IP
+	    addresses on all our subnets on the outgoing interface that
+	    include the target IP address.  If no suitable local address is
+	    found we select the first local address we have on the outgoing
+	    interface or on all other interfaces, with the hope we will
+	    receive reply for our request and even sometimes no matter the
+	    source IP address we announce.
 
-	conf/all/rp_filter must also be set to TRUE to do source validation
-	on the interface
+	The max value from conf/{all,interface}/arp_announce is used.
 
-	Default value is 0. Note that some distributions enable it
-	in startup scripts.
+	Increasing the restriction level gives more chance for receiving
+	answer from the resolved target while decreasing the level announces
+	more valid sender's information.
+	Default: 0
 
 arp_filter - BOOLEAN
 	1 - Allows you to have multiple network interfaces on the same
-	subnet, and have the ARPs for each interface be answered
-	based on whether or not the kernel would route a packet from
-	the ARP'd IP out that interface (therefore you must use source
-	based routing for this to work). In other words it allows control
-	of which cards (usually 1) will respond to an arp request.
-
-	0 - (default) The kernel can respond to arp requests with addresses
-	from other interfaces. This may seem wrong but it usually makes
-	sense, because it increases the chance of successful communication.
-	IP addresses are owned by the complete host on Linux, not by
-	particular interfaces. Only for more complex setups like load-
-	balancing, does this behaviour cause problems.
+	    subnet, and have the ARPs for each interface be answered based
+	    on whether or not the kernel would route a packet from the ARP'd
+	    IP out that interface (therefore you must use source based
+	    routing for this to work).  In other words it allows control of
+	    which cards (usually 1) will respond to an ARP request.
+
+	0 - The kernel can respond to ARP requests with addresses from other
+	    interfaces.  This may seem wrong but it usually makes sense,
+	    because it increases the chance of successful communication.  IP
+	    addresses are owned by the complete host on Linux, not by
+	    particular interfaces.  Only for more complex setups like load-
+	    balancing, does this behaviour cause problems.
 
 	arp_filter for the interface will be enabled if at least one of
-	conf/{all,interface}/arp_filter is set to TRUE,
-	it will be disabled otherwise
-
-arp_announce - INTEGER
-	Define different restriction levels for announcing the local
-	source IP address from IP packets in ARP requests sent on
-	interface:
-	0 - (default) Use any local address, configured on any interface
-	1 - Try to avoid local addresses that are not in the target's
-	subnet for this interface. This mode is useful when target
-	hosts reachable via this interface require the source IP
-	address in ARP requests to be part of their logical network
-	configured on the receiving interface. When we generate the
-	request we will check all our subnets that include the
-	target IP and will preserve the source address if it is from
-	such subnet. If there is no such subnet we select source
-	address according to the rules for level 2.
-	2 - Always use the best local address for this target.
-	In this mode we ignore the source address in the IP packet
-	and try to select local address that we prefer for talks with
-	the target host. Such local address is selected by looking
-	for primary IP addresses on all our subnets on the outgoing
-	interface that include the target IP address. If no suitable
-	local address is found we select the first local address
-	we have on the outgoing interface or on all other interfaces,
-	with the hope we will receive reply for our request and
-	even sometimes no matter the source IP address we announce.
-
-	The max value from conf/{all,interface}/arp_announce is used.
-
-	Increasing the restriction level gives more chance for
-	receiving answer from the resolved target while decreasing
-	the level announces more valid sender's information.
+	conf/{all,interface}/arp_filter is set to 1, it will be disabled
+	otherwise.
+	Default: 0
 
 arp_ignore - INTEGER
-	Define different modes for sending replies in response to
-	received ARP requests that resolve local target IP addresses:
-	0 - (default): reply for any local target IP address, configured
-	on any interface
-	1 - reply only if the target IP address is local address
-	configured on the incoming interface
-	2 - reply only if the target IP address is local address
-	configured on the incoming interface and both with the
-	sender's IP address are part from same subnet on this interface
-	3 - do not reply for local addresses configured with scope host,
-	only resolutions for global and link addresses are replied
+	Define different modes for sending replies in response to received
+	ARP requests that resolve local target IP addresses:
+	0   - reply for any local target IP address, configured on any
+	      interface
+	1   - reply only if the target IP address is local address
+	      configured on the incoming interface
+	2   - reply only if the target IP address is local address
+	      configured on the incoming interface and both with the
+	      sender's IP address are part from same subnet on this
+	      interface
+	3   - do not reply for local addresses configured with scope host,
+	      only resolutions for global and link addresses are replied
 	4-7 - reserved
-	8 - do not reply for all local addresses
+	8   - do not reply for all local addresses
 
-	The max value from conf/{all,interface}/arp_ignore is used
-	when ARP request is received on the {interface}
-
-arp_accept - BOOLEAN
-	Define behavior when gratuitous arp replies are received:
-	0 - drop gratuitous arp frames
-	1 - accept gratuitous arp frames
+	The max value from conf/{all,interface}/arp_ignore is used when ARP
+	request is received on the {interface}.
+	Default: 0
 
-app_solicit - INTEGER
-	The maximum number of probes to send to the user space ARP daemon
-	via netlink before dropping back to multicast probes (see
-	mcast_solicit).  Defaults to 0.
+bootp_relay - BOOLEAN
+	Accept packets with source address 0.b.c.d destined not to this host
+	as local ones.  It is supposed, that BOOTP relay daemon will catch
+	and forward such packets.  conf/all/bootp_relay must also be set to
+	1 to enable BOOTP relay for the interface.
+	Default: 0
+	Not Implemented Yet.
 
 disable_policy - BOOLEAN
 	Disable IPSEC policy (SPD) for this interface
+	Default: 0
 
 disable_xfrm - BOOLEAN
 	Disable IPSEC encryption on this interface, whatever the policy
+	Default: 0
 
+force_igmp_version - INTEGER
+	TODO Add description.
 
+forwarding - BOOLEAN
+	Enable IP forwarding on this interface.
+	Default: 0
 
-tag - INTEGER
-	Allows you to write a number, which can be used as required.
-	Default value is 0.
+log_martians - BOOLEAN
+	Log packets with impossible addresses to kernel log.  log_martians
+	for the interface will be enabled if at least one of
+	conf/{all,interface}/log_martians is set to 1, it will be disabled
+	otherwise
+	Default: 0
 
-(1) Jiffie: internal timeunit for the kernel. On the i386 1/100s, on the
-Alpha 1/1024s. See the HZ define in /usr/include/asm/param.h for the exact
-value on your system. 
+mc_forwarding - BOOLEAN
+	Do multicast routing.  The kernel needs to be compiled with
+	CONFIG_MROUTE and a multicast routing daemon is required.
+	conf/all/mc_forwarding must also be set to 1 to enable multicast
+	routing for the interface
+	Default: 0
 
-Alexey Kuznetsov.
-kuznet@ms2.inr.ac.ru
+medium_id - INTEGER
+	Integer value used to differentiate the devices by the medium they
+	are attached to.  Two devices can have different id values when the
+	broadcast packets are received only on one of them.  The value 0
+	means that the device is the only interface to its medium, value of
+	-1 means that medium is not known.
+
+	Currently, it is used to change the proxy_arp behavior: the
+	proxy_arp feature is enabled for packets forwarded between two
+	devices attached to different media.
+	Default: 0
+
+promote_secondaries - ????
+	TODO Add description.
+
+proxy_arp - BOOLEAN
+	Do proxy ARP.
+	proxy_arp for the interface will be enabled if at least one of
+	conf/{all,interface}/proxy_arp is set to 1, it will be disabled
+	otherwise.
+	Default: 0
+
+rp_filter - BOOLEAN
+	1 - do source validation by reversed path, as specified in RFC1812
+	    Recommended option for single homed hosts and stub network
+	    routers.  Could cause troubles for complicated (not loop free)
+	    networks running a slow unreliable protocol (sort of RIP), or
+	    using static routes.
+	0 - No source validation.
+
+	conf/all/rp_filter must also be set to 1 to do source validation on
+	the interface
+
+	Default: 0.  Note that some distributions enable it in startup
+	scripts.
+
+secure_redirects - BOOLEAN
+	Accept ICMP redirect messages only for gateways, listed in default
+	gateway list.
+	secure_redirects for the interface will be enabled if at least one
+	of conf/{all,interface}/secure_redirects is set to 1, it will be
+	disabled otherwise
+	Default: 1
 
-Updated by:
-Andi Kleen
-ak@muc.de
-Nicolas Delon
-delon.nicolas@wanadoo.fr
+send_redirects - BOOLEAN
+	Send redirects, if router.
+	send_redirects for the interface will be enabled if at least one of
+	conf/{all,interface}/send_redirects is set to 1, it will be disabled
+	otherwise
+	Default: 1
 
+shared_media - BOOLEAN
+	Send(router) or accept(host) RFC1620 shared media redirects.
+	Overrides ip_secure_redirects.
+	shared_media for the interface will be enabled if at least one of
+	conf/{all,interface}/shared_media is set to 1, it will be disabled
+	otherwise
+	Default: 1
 
+tag - INTEGER
+	Allows you to write a number, which can be used as required.
+	Default: 0
 
 
 /proc/sys/net/ipv6/* Variables:
@@ -670,155 +825,208 @@ IPv6 has no global variables such as tcp
 apply to IPv6 [XXX?].
 
 bindv6only - BOOLEAN
-	Default value for IPV6_V6ONLY socket option,
-	which restricts use of the IPv6 socket to IPv6 communication 
-	only.
-		TRUE: disable IPv4-mapped address feature
-		FALSE: enable IPv4-mapped address feature
-
-	Default: FALSE (as specified in RFC2553bis)
-
-IPv6 Fragmentation:
+	Default value for IPV6_V6ONLY socket option, which restricts use of
+	the IPv6 socket to IPv6 communication only.
+		1: disable IPv4-mapped address feature
+		0: enable IPv4-mapped address feature
+	Default: 0 (as specified in RFC2553bis)
 
 ip6frag_high_thresh - INTEGER
-	Maximum memory used to reassemble IPv6 fragments. When 
+	Maximum memory used to reassemble IPv6 fragments.  When
 	ip6frag_high_thresh bytes of memory is allocated for this purpose,
-	the fragment handler will toss packets until ip6frag_low_thresh
-	is reached.
-	
-ip6frag_low_thresh - INTEGER
-	See ip6frag_high_thresh	
+	the fragment handler will toss packets until ip6frag_low_thresh is
+	reached.
+	Default: 256k
 
-ip6frag_time - INTEGER
-	Time in seconds to keep an IPv6 fragment in memory.
+ip6frag_low_thresh - INTEGER
+	See ip6frag_high_thresh
+	Default: 192k
 
 ip6frag_secret_interval - INTEGER
-	Regeneration interval (in seconds) of the hash secret (or lifetime 
+	Regeneration interval (in seconds) of the hash secret (or lifetime
 	for the hash secret) for IPv6 fragments.
 	Default: 600
 
-conf/default/*:
-	Change the interface-specific default settings.
+ip6frag_time - INTEGER
+	Time in seconds to keep an IPv6 fragment in memory.
+	Default: 60
+
+mld_max_msf - INTEGER
+	TODO Add description.
 
 
-conf/all/*:
-	Change all the interface-specific settings.  
+/proc/sys/net/ipv6/icmp/* Variables:
 
-	[XXX:  Other special features than forwarding?]
+ratelimit - INTEGER
+	Limit the maximal rates for sending ICMPv6 packets.
+	0 to disable any limiting, otherwise the maximal rate in jiffies(1).
+	Default: jiffies in one second
 
-conf/all/forwarding - BOOLEAN
-	Enable global IPv6 forwarding between all interfaces.  
 
-	IPv4 and IPv6 work differently here; e.g. netfilter must be used 
-	to control which interfaces may forward packets and which not.
+/proc/sys/net/ipv6/route/* Variables:
 
-	This also sets all interfaces' Host/Router setting 
-	'forwarding' to the specified value.  See below for details.
+flush - INTEGER
+	TODO Add description.
+	See ipv4/route/flush description.
 
-	This referred to as global forwarding.
+gc_elasticity - INTEGER
+	TODO Add description.
+	See ipv4/route/gc_elasticity description.
 
-conf/interface/*:
-	Change special settings per interface.
+gc_interval - INTEGER
+	TODO Add description.
+	See ipv4/route/gc_interval description.
 
-	The functional behaviour for certain settings is different 
-	depending on whether local forwarding is enabled or not.
+gc_min_interval - INTEGER
+	TODO Add description.
+	See ipv4/route/gc_min_interval description.
+
+gc_min_interval_ms - INTEGER
+	TODO Add description.
+	See ipv4/route/gc_min_interval_ms description.
+
+gc_thresh - INTEGER
+	TODO Add description.
+	See ipv4/route/gc_thresh description.
+
+gc_timeout - INTEGER
+	TODO Add description.
+	See ipv4/route/gc_timeout description.
+
+max_size - INTEGER
+	TODO Add description.
+	See ipv4/route/max_size description.
+
+min_adv_mss - INTEGER
+	TODO Add description.
+	See ipv4/route/min_adv_mss description.
+
+mtu_expires - INTEGER
+	TODO Add description.
+	See ipv4/route/mtu_expires description.
+
+
+/proc/sys/net/ipv6/conf/*/*
+/proc/sys/net/ipv6/conf/all/*
+/proc/sys/net/ipv6/conf/default/*
 
 accept_ra - BOOLEAN
 	Accept Router Advertisements; autoconfigure using them.
-	
-	Functional default: enabled if local forwarding is disabled.
-			    disabled if local forwarding is enabled.
+
+	Default: enabled if local forwarding is disabled.
+		 disabled if local forwarding is enabled.
 
 accept_ra_defrtr - BOOLEAN
 	Learn default router in Router Advertisement.
 
-	Functional default: enabled if accept_ra is enabled.
-			    disabled if accept_ra is disabled.
+	Default: enabled if accept_ra is enabled.
+		 disabled if accept_ra is disabled.
 
 accept_ra_pinfo - BOOLEAN
 	Learn Prefix Inforamtion in Router Advertisement.
 
-	Functional default: enabled if accept_ra is enabled.
-			    disabled if accept_ra is disabled.
+	Default: enabled if accept_ra is enabled.
+		 disabled if accept_ra is disabled.
 
 accept_ra_rt_info_max_plen - INTEGER
 	Maximum prefix length of Route Information in RA.
 
-	Route Information w/ prefix larger than or equal to this
-	variable shall be ignored.
+	Route Information with prefix larger than or equal to this variable
+	shall be ignored.
 
-	Functional default: 0 if accept_ra_rtr_pref is enabled.
-			    -1 if accept_ra_rtr_pref is disabled.
+	Default: 0 if accept_ra_rtr_pref is enabled.
+		 -1 if accept_ra_rtr_pref is disabled.
 
 accept_ra_rtr_pref - BOOLEAN
 	Accept Router Preference in RA.
 
-	Functional default: enabled if accept_ra is enabled.
-			    disabled if accept_ra is disabled.
+	Default: enabled if accept_ra is enabled.
+		 disabled if accept_ra is disabled.
 
 accept_redirects - BOOLEAN
 	Accept Redirects.
 
-	Functional default: enabled if local forwarding is disabled.
-			    disabled if local forwarding is enabled.
+	Default: enabled if local forwarding is disabled.
+		 disabled if local forwarding is enabled.
 
 autoconf - BOOLEAN
-	Autoconfigure addresses using Prefix Information in Router 
+	Autoconfigure addresses using Prefix Information in Router
 	Advertisements.
 
-	Functional default: enabled if accept_ra_pinfo is enabled.
-			    disabled if accept_ra_pinfo is disabled.
+	Default: enabled if accept_ra_pinfo is enabled.
+		 disabled if accept_ra_pinfo is disabled.
 
 dad_transmits - INTEGER
 	The amount of Duplicate Address Detection probes to send.
 	Default: 1
-	
+
+force_mld_version - INTEGER
+	TODO Add description.
+	Default: 0
+
 forwarding - BOOLEAN
-	Configure interface-specific Host/Router behaviour.  
+	Configure interface-specific Host/Router behaviour.
 
-	Note: It is recommended to have the same setting on all 
-	interfaces; mixed router/host scenarios are rather uncommon.
+	Note: It is recommended to have the same setting on all interfaces;
+	mixed router/host scenarios are rather uncommon.
 
-	FALSE:
+	FALSE (0):
 
 	By default, Host behaviour is assumed.  This means:
 
 	1. IsRouter flag is not set in Neighbour Advertisements.
 	2. Router Solicitations are being sent when necessary.
-	3. If accept_ra is TRUE (default), accept Router 
-	   Advertisements (and do autoconfiguration).
-	4. If accept_redirects is TRUE (default), accept Redirects.
+	3. If accept_ra is 1 (default), accept Router Advertisements (and
+	   do autoconfiguration).
+	4. If accept_redirects is 1 (default), accept Redirects.
 
-	TRUE:
+	TRUE (1):
 
-	If local forwarding is enabled, Router behaviour is assumed. 
-	This means exactly the reverse from the above:
+	If local forwarding is enabled, Router behaviour is assumed.  This
+	means exactly the reverse from the above:
 
 	1. IsRouter flag is set in Neighbour Advertisements.
 	2. Router Solicitations are not sent.
 	3. Router Advertisements are ignored.
 	4. Redirects are ignored.
 
-	Default: FALSE if global forwarding is disabled (default),
-		 otherwise TRUE.
+	Default: 0 if global forwarding is disabled (default),
+		 otherwise 1.
 
 hop_limit - INTEGER
 	Default Hop Limit to set.
 	Default: 64
 
+max_addresses - INTEGER
+	Number of maximum addresses per interface.  0 disables limitation.
+	It is recommended not set too large value (or 0) because it would be
+	too easy way to crash kernel to allow to create too much of
+	autoconfigured addresses.
+	Default: 16
+
+max_desync_factor - INTEGER
+	Maximum value in seconds for DESYNC_FACTOR, which is a random value
+	that ensures that clients don't synchronize with each other and
+	generate new addresses at exactly the same time.
+	Default: 600
+
 mtu - INTEGER
 	Default Maximum Transfer Unit
 	Default: 1280 (IPv6 required minimum)
 
+regen_max_retry - INTEGER
+	Number of attempts before give up attempting to generate valid
+	temporary addresses.
+	Default: 5
+
 router_probe_interval - INTEGER
 	Minimum interval (in seconds) between Router Probing described
 	in RFC4191.
-
 	Default: 60
 
 router_solicitation_delay - INTEGER
-	Number of seconds to wait after interface is brought up
-	before sending Router Solicitations.
+	Number of seconds to wait after interface is brought up before
+	sending Router Solicitations.
 	Default: 1
 
 router_solicitation_interval - INTEGER
@@ -826,57 +1034,102 @@ router_solicitation_interval - INTEGER
 	Default: 4
 
 router_solicitations - INTEGER
-	Number of Router Solicitations to send until assuming no 
-	routers are present.
+	Number of Router Solicitations to send until assuming no routers are
+	present.
 	Default: 3
 
+temp_prefered_lft - INTEGER
+	Preferred lifetime (in seconds) for temporary addresses.
+	Default: 86400 (1 day)
+
+temp_valid_lft - INTEGER
+	Valid lifetime (in seconds) for temporary addresses.
+	Default: 604800 (7 days)
+
 use_tempaddr - INTEGER
 	Preference for Privacy Extensions (RFC3041).
 	  <= 0 : disable Privacy Extensions
-	  == 1 : enable Privacy Extensions, but prefer public
-	         addresses over temporary addresses.
-	  >  1 : enable Privacy Extensions and prefer temporary
-	         addresses over public addresses.
-	Default:  0 (for most devices)
-		 -1 (for point-to-point devices and loopback devices)
+	  == 1 : enable Privacy Extensions, but prefer public addresses over
+	         temporary addresses.
+	  >  1 : enable Privacy Extensions and prefer temporary addresses
+	         over public addresses.
+	Values 0 for most devices and -1 for point-to-point devices and
+	loopback devices.
+	Default: 0
 
-temp_valid_lft - INTEGER
-	valid lifetime (in seconds) for temporary addresses.
-	Default: 604800 (7 days)
 
-temp_prefered_lft - INTEGER
-	Preferred lifetime (in seconds) for temporary addresses.
-	Default: 86400 (1 day)
+/proc/sys/net/unix/* Variables:
 
-max_desync_factor - INTEGER
-	Maximum value for DESYNC_FACTOR, which is a random value
-	that ensures that clients don't synchronize with each 
-	other and generate new addresses at exactly the same time.
-	value is in seconds.
-	Default: 600
-	
-regen_max_retry - INTEGER
-	Number of attempts before give up attempting to generate
-	valid temporary addresses.
-	Default: 5
+max_dgram_qlen - INTEGER
+	TODO Add description.
+	Default: 10
 
-max_addresses - INTEGER
-	Number of maximum addresses per interface.  0 disables limitation.
-	It is recommended not set too large value (or 0) because it would 
-	be too easy way to crash kernel to allow to create too much of 
-	autoconfigured addresses.
-	Default: 16
 
-icmp/*:
-ratelimit - INTEGER
-	Limit the maximal rates for sending ICMPv6 packets.
-	0 to disable any limiting, otherwise the maximal rate in jiffies(1)
-	Default: 100
+/proc/sys/net/ipv[46]/neigh/*/*
+/proc/sys/net/ipv[46]/neigh/default/*
 
+anycast_delay - INTEGER
+	TODO Add description.
 
-IPv6 Update by:
-Pekka Savola <pekkas@netcore.fi>
-YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
+app_solicit - INTEGER
+	The maximum number of probes to send to the user space ARP daemon
+	via netlink before dropping back to multicast probes (see
+	mcast_solicit).
+	Default: 0
+
+base_reachable_time - INTEGER
+	TODO Check description.
+	See base_reachable_time_ms.
+
+base_reachable_time_ms - INTEGER
+	TODO Add description.
+	Default: 30000
+
+delay_first_probe_time - ????
+	TODO Add description.
+
+gc_interval - INTEGER
+	TODO Add description.
+	Default: 30
+
+gc_stale_time - ????
+	TODO Add description.
+
+gc_thresh1 - ????
+	TODO Add description.
+
+gc_thresh2 - ????
+	TODO Add description.
+
+gc_thresh3 - ????
+	TODO Add description.
+
+locktime - ????
+	TODO Add description.
+
+mcast_solicit - ????
+	TODO Add description.
+
+proxy_delay - INTEGER
+	TODO Add description.
+	Default: 80
+
+proxy_qlen - INTEGER
+	TODO Add description.
+	Default: 64
+
+retrans_time - ????
+	TODO Check description.
+	See retrans_time_ms.
+
+retrans_time_ms - ????
+	TODO Add description.
+
+ucast_solicit - ????
+	TODO Add description.
+
+unres_qlen - ????
+	TODO Add description.
 
 
 /proc/sys/net/bridge/* Variables:
@@ -886,13 +1139,13 @@ bridge-nf-call-arptables - BOOLEAN
 	0 : disable this.
 	Default: 1
 
-bridge-nf-call-iptables - BOOLEAN
-	1 : pass bridged IPv4 traffic to iptables' chains.
+bridge-nf-call-ip6tables - BOOLEAN
+	1 : pass bridged IPv6 traffic to ip6tables' chains.
 	0 : disable this.
 	Default: 1
 
-bridge-nf-call-ip6tables - BOOLEAN
-	1 : pass bridged IPv6 traffic to ip6tables' chains.
+bridge-nf-call-iptables - BOOLEAN
+	1 : pass bridged IPv4 traffic to iptables' chains.
 	0 : disable this.
 	Default: 1
 
@@ -902,25 +1155,21 @@ bridge-nf-filter-vlan-tagged - BOOLEAN
 	Default: 1
 
 
-UNDOCUMENTED:
-
-dev_weight FIXME
-discovery_slots FIXME
-discovery_timeout FIXME
-fast_poll_increase FIXME
-ip6_queue_maxlen FIXME
-lap_keepalive_time FIXME
-lo_cong FIXME
-max_baud_rate FIXME
-max_dgram_qlen FIXME
-max_noreply_time FIXME
-max_tx_data_size FIXME
-max_tx_window FIXME
-min_tx_turn_time FIXME
-mod_cong FIXME
-no_cong FIXME
-no_cong_thresh FIXME
-slot_timeout FIXME
-warn_noreply_time FIXME
-
-$Id: ip-sysctl.txt,v 1.20 2001/12/13 09:00:18 davem Exp $
+(1) Jiffie: internal timeunit for the kernel.  On the i386 1/100s, on the
+Alpha 1/1024s.  See the HZ define in /usr/include/asm/param.h for the exact
+value on your system.
+
+
+IPv4:
+Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
+IPv4 Updated by:
+Andi Kleen <ak@muc.de>
+Nicolas Delon <delon.nicolas@wanadoo.fr>
+
+IPv6 Updated by:
+Pekka Savola <pekkas@netcore.fi>
+YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
+
+Reformatted/Updated:
+Robert Fitzsimons <robfitz@273k.net>, June 2006 synced with 2.6.17-rc6.
+
--
1.3.3.g16a4-dirty


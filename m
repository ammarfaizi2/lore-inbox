Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbQLKQNc>; Mon, 11 Dec 2000 11:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129598AbQLKQNW>; Mon, 11 Dec 2000 11:13:22 -0500
Received: from montreal.eicon.com ([192.219.17.120]:14597 "EHLO
	mtl_exchange.eicon.com") by vger.kernel.org with ESMTP
	id <S129511AbQLKQNP>; Mon, 11 Dec 2000 11:13:15 -0500
Message-ID: <D8E12241B029D411A3A300805FE6A2B9C554C4@montreal.eicon.com>
From: Carlo Pagano <carlop@Eicon.com>
To: linux-kernel@vger.kernel.org
Subject: Wait Queues
Date: Mon, 11 Dec 2000 10:43:35 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.0.1460.8)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C06389.1F9140BA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C06389.1F9140BA
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am trying to modify a driver that worked great on 2.2.16 to 2.4.0-x..
=A0
My old code was:
=A0
static struct wait_queue *roundrobin_wait;=20
static struct wait_queue *task_stop_wait;=20
=A0
static struct tq_struct roundrobin_task;=20
static struct timer_list timeout_timer;=20
=A0
...
=A0
init_timer(&timeout_timer);=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
timeout_timer.function =3D Timer;=20
timeout_timer.data =3D (unsigned long)&timer_data;=20
timeout_timer.expires =3D jiffies + 3*HZ;
=A0
void Timer(unsigned long ptr)=20
{=20
=A0=A0=A0 struct clientdata *pTimerData =3D (struct clientdata *) ptr;
=A0
if (pTimerData->one_shot_queue_task){
=A0=A0=A0=A0=A0=A0=A0 // start the main round robin
=A0=A0=A0=A0=A0=A0=A0 queue_task(&roundrobin_task, &tq_scheduler);=20
=A0=A0=A0=A0=A0=A0=A0 pTimerData->one_shot_queue_task =3D FALSE;
=A0=A0=A0 }
=A0
=A0=A0=A0 /* wake-up the task responsible for the Timeout callbacks =
round-robin */
=A0=A0=A0 wake_up_interruptible(&roundrobin_wait);=20
=A0
=A0=A0=A0 /* re-schedule this Timer function */
=A0=A0=A0 =
init_timer(&timeout_timer);=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
=A0=A0=A0 timeout_timer.function =3D Timer;=20
=A0=A0=A0 timeout_timer.data =3D (unsigned long)&timer_data;=20
=A0=A0=A0 timeout_timer.expires =3D jiffies + HZ/100;=20
=A0=A0=A0 add_timer(&timeout_timer);=20
}=20
=A0
void RoundRobin(void *ptr)=20
{=20
=A0=A0=A0 struct clientdata *data =3D (struct clientdata *) ptr;
=A0
=A0=A0=A0 interruptible_sleep_on(&roundrobin_wait);=20
=A0
=A0=A0=A0 if (data->queue)=A0=A0=A0 // data->queue set to NULL in =
Stop()
=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0 /* do whatever you want to do here ... */=20
=A0=A0=A0=A0=A0=A0=A0 OSALTimeoutCallback *pCallback =3D =
data->callback;=20
=A0
=A0=A0=A0=A0=A0=A0=A0 pCallback->RoundRobinCallbacks();=20
=A0=A0=A0 }
=A0
=A0=A0=A0 /* re-register itself, if needed */=20
=A0=A0=A0 roundrobin_task.routine =3D RoundRobin; //main_round_robin;=20
=A0=A0=A0 roundrobin_task.data =3D (void *) &roundrobin_data;=20
=A0=A0=A0 if (data->queue)
=A0=A0=A0 {=20
=A0=A0=A0=A0=A0=A0=A0 queue_task(&roundrobin_task, data->queue);=20
=A0=A0=A0 }=20
=A0=A0=A0 else=20
=A0=A0=A0 {=20
=A0=A0=A0=A0=A0=A0=A0 wake_up_interruptible(&task_stop_wait);=20
=A0
=A0=A0=A0 }=20
}=20
=A0
=A0
=A0
=A0
=A0
Carlo Pagano
Software Designer
Trisignal Communications, a division of=A0i-data Technology
(514) 832-3603
carlop@trisignal.com
=A0

------_=_NextPart_001_01C06389.1F9140BA
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">


<META content="MSHTML 5.50.4134.600" name=GENERATOR></HEAD>
<BODY bgColor=#ffffff>
<DIV><FONT face=Tahoma size=2>I am trying to modify a driver that worked great 
on 2.2.16 to 2.4.0-x..</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Tahoma size=2>My old code was:</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Tahoma size=2>static struct wait_queue *roundrobin_wait; 
<BR>static struct wait_queue *task_stop_wait; <BR>&nbsp;<BR>static struct 
tq_struct roundrobin_task; <BR>static struct timer_list timeout_timer; 
</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Tahoma size=2>...</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Tahoma 
size=2>init_timer(&amp;timeout_timer);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<BR>timeout_timer.function = Timer; <BR>timeout_timer.data = (unsigned 
long)&amp;timer_data; <BR>timeout_timer.expires = jiffies + 3*HZ;</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Tahoma size=2>void Timer(unsigned long ptr) <BR>{ 
<BR>&nbsp;&nbsp;&nbsp; struct clientdata *pTimerData = (struct clientdata *) 
ptr;</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Tahoma size=2>if 
(pTimerData-&gt;one_shot_queue_task){<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
// start the main round robin<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
queue_task(&amp;roundrobin_task, &amp;tq_scheduler); 
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
pTimerData-&gt;one_shot_queue_task = FALSE;<BR>&nbsp;&nbsp;&nbsp; }</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Tahoma size=2>&nbsp;&nbsp;&nbsp; /* wake-up the task responsible 
for the Timeout callbacks round-robin */<BR>&nbsp;&nbsp;&nbsp; 
wake_up_interruptible(&amp;roundrobin_wait); </FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Tahoma size=2>&nbsp;&nbsp;&nbsp; /* re-schedule this Timer 
function */<BR>&nbsp;&nbsp;&nbsp; 
init_timer(&amp;timeout_timer);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<BR>&nbsp;&nbsp;&nbsp; timeout_timer.function = Timer; <BR>&nbsp;&nbsp;&nbsp; 
timeout_timer.data = (unsigned long)&amp;timer_data; <BR>&nbsp;&nbsp;&nbsp; 
timeout_timer.expires = jiffies + HZ/100; <BR>&nbsp;&nbsp;&nbsp; 
add_timer(&amp;timeout_timer); <BR>} <BR>&nbsp;<BR>void RoundRobin(void *ptr) 
<BR>{ <BR>&nbsp;&nbsp;&nbsp; struct clientdata *data = (struct clientdata *) 
ptr;</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Tahoma size=2>&nbsp;&nbsp;&nbsp; 
interruptible_sleep_on(&amp;roundrobin_wait); </FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Tahoma size=2>&nbsp;&nbsp;&nbsp; if 
(data-&gt;queue)&nbsp;&nbsp;&nbsp; // data-&gt;queue set to NULL in 
Stop()<BR>&nbsp;&nbsp;&nbsp; {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 
do whatever you want to do here ... */ 
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OSALTimeoutCallback *pCallback = 
data-&gt;callback; </FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Tahoma size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
pCallback-&gt;RoundRobinCallbacks(); <BR>&nbsp;&nbsp;&nbsp; }</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Tahoma size=2>&nbsp;&nbsp;&nbsp; /* re-register itself, if 
needed */ <BR>&nbsp;&nbsp;&nbsp; roundrobin_task.routine = RoundRobin; 
//main_round_robin; <BR>&nbsp;&nbsp;&nbsp; roundrobin_task.data = (void *) 
&amp;roundrobin_data; <BR>&nbsp;&nbsp;&nbsp; if 
(data-&gt;queue)<BR>&nbsp;&nbsp;&nbsp; { 
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_task(&amp;roundrobin_task, 
data-&gt;queue); <BR>&nbsp;&nbsp;&nbsp; } <BR>&nbsp;&nbsp;&nbsp; else 
<BR>&nbsp;&nbsp;&nbsp; { <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
wake_up_interruptible(&amp;task_stop_wait); </FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Tahoma size=2>&nbsp;&nbsp;&nbsp; } <BR>} </FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Tahoma size=2></FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Tahoma size=2></FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Tahoma size=2><STRONG>Carlo Pagano</STRONG></FONT></DIV>
<DIV><FONT face=Tahoma size=2>Software Designer</FONT></DIV>
<DIV><FONT face=Tahoma size=2>Trisignal Communications, a division 
of&nbsp;i-data Technology</FONT></DIV>
<DIV><FONT face=Tahoma size=2>(514) 832-3603</FONT></DIV>
<DIV><A href="mailto:carlop@trisignal.com"><FONT face=Tahoma 
size=2>carlop@trisignal.com</FONT></A></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C06389.1F9140BA--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
